
import java.util.HashSet;
import java.util.Random;
import java.util.List;
import java.util.Set;

import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.SimpleBehaviour;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;

public class AgentSender extends Agent{

	protected List<String> data;
	/**
	 * This method is automatically called when "agent".start() is executed.
	 * Consider that Agent is launched for the first time. 
	 * 			1 set the agent attributes 
	 *	 		2 add the behaviours
	 *          
	 */
	protected void setup(){

		super.setup();

//		//get the parameters given into the object[]
//		final Object[] args = getArguments();
//		if(args[0]!=null){
//			data = (List<String>) args[0];
//
//		}else{
//			System.out.println("Erreur lors du tranfert des parametres");
//		}

		//Add the behaviours
		//EX1
		//addBehaviour(new SendMessage(this));
		
		//EX2
		//addBehaviour(new Send10Integers(this));
		//addBehaviour(new ReceiveMessage(this));
		
		//EX3
		//addBehaviour(new SendXIntegers(this));
		//addBehaviour(new ReceiveMessage(this));

		//EX4
		addBehaviour(new SendIntegersOnDemand(this));
		
		System.out.println("the sender agent "+this.getLocalName()+ " is started");
		
	}

	/**
	 * This method is automatically called after doDelete()
	 */
	protected void takeDown(){

	}

	
	/**************************************
	 * 
	 * 
	 * 				BEHAVIOURS
	 * 
	 * 
	 **************************************/

	public class SendMessage extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour is the first step of the paxos
		 *  
		 */
		private static final long serialVersionUID = 9088209402507795289L;

		private boolean finished=false;

		public SendMessage(final Agent myagent) {
			super(myagent);

		}


		public void action() {
			//Create a message in order to send it to the choosen agent
			final ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
			msg.setSender(this.myAgent.getAID());
			//msg.setLanguage(MyOntology.LANGUAGE);
			//msg.setOntology(MyOntology.ONTOLOGY_NAME);
			//msg.setProtocol(MyOntology.PAXOS_PREPARE);
			
			msg.addReceiver(new AID("Agent1", AID.ISLOCALNAME)); // hardcoded= bad, must give it with objtab
				
			msg.setContent(((AgentSender)this.myAgent).data.get(0));

			this.myAgent.send(msg);
			this.finished=true;
			System.out.println("----> Message sent to "+msg.getAllReceiver().next()+" ,content= "+msg.getContent());

		}

		public boolean done() {
			return finished;
		}

	}
	
	public class Send10Integers extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour sends 10 randomly chosen integers. (EXO 2 TP 1)
		 *  
		 */

		private static final long serialVersionUID = 1L;

		private boolean finished=false;

		public Send10Integers(final Agent myagent) {
			super(myagent);
		}


		public void action() {
			//Create a message in order to send it to the choosen agent
			final ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
			msg.setSender(this.myAgent.getAID());
			//msg.setLanguage(MyOntology.LANGUAGE);
			//msg.setOntology(MyOntology.ONTOLOGY_NAME);
			//msg.setProtocol(MyOntology.PAXOS_PREPARE);
			
			Random rng = new Random();
			
			msg.addReceiver(new AID("Agent1", AID.ISLOCALNAME)); // hardcoded= bad, must give it with objtab
			
			for(int i = 0; i < 10; i++)
			{
				int n = rng.nextInt(100)+1;
				msg.setContent(Integer.toString(n));
				this.myAgent.send(msg);
				System.out.println("----> Message sent to "+msg.getAllReceiver().next()+" ,content= "+msg.getContent());
			}

			this.finished=true;
			System.out.println("10 Messages sent");

		}

		public boolean done() {
			return finished;
		}

	}
	
	public class SendXIntegers extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour sends X randomly chosen integers given in data[0]. (EXO 3 TP 1)
		 *  
		 */

		private static final long serialVersionUID = 1L;

		private boolean finished=false;

		public SendXIntegers(final Agent myagent) {
			super(myagent);
		}


		public void action() {
			//Create a message in order to send it to the choosen agent
			final ACLMessage msg = new ACLMessage(ACLMessage.INFORM);
			msg.setSender(this.myAgent.getAID());
			//msg.setLanguage(MyOntology.LANGUAGE);
			//msg.setOntology(MyOntology.ONTOLOGY_NAME);
			//msg.setProtocol(MyOntology.PAXOS_PREPARE);
			
			final int X = Integer.parseInt(data.get(0));
			
			Random rng = new Random();
			
			msg.addReceiver(new AID("Agent1", AID.ISLOCALNAME)); // hardcoded= bad, must give it with objtab
			
			for(int i = 0; i < X; i++)
			{
				int n = rng.nextInt(100)+1;
				msg.setContent(Integer.toString(n));
				this.myAgent.send(msg);
				System.out.println("----> Message sent to "+msg.getAllReceiver().next()+" ,content= "+msg.getContent());
			}

			this.finished=true;
			System.out.println(X + " Messages sent");

		}

		public boolean done() {
			return finished;
		}

	}

	
	public class ReceiveMessage extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour is the first step of the paxos
		 *  
		 */
		int X = Integer.parseInt(data.get(0));
		private static final long serialVersionUID = 908820940257795289L;

		private boolean finished=false;

		public ReceiveMessage(final Agent myagent) {
			super(myagent);

		}


		public void action() {
			//1) receive the message
			final MessageTemplate msgTemplate = MessageTemplate.MatchPerformative(ACLMessage.INFORM);
				//MessageTemplate.and(
					//MessageTemplate.MatchPerformative(ACLMessage.DISCONFIRM),
					//MessageTemplate.and(
					//		MessageTemplate.MatchProtocol(MyOntology.PAXOS_QUIT_COALITION),
					//		MessageTemplate.and(
					//				MessageTemplate.MatchLanguage(MyOntology.LANGUAGE),
					//				MessageTemplate.MatchOntology(MyOntology.ONTOLOGY_NAME))
					//)
			

			final ACLMessage msg = this.myAgent.receive(msgTemplate);
			if (msg != null) {		
				System.out.println("<----Message received from "+msg.getSender().getLocalName()+" ,sum of "+ X +" integers sent= "+msg.getContent());
				this.finished=true;
			}
		}

		public boolean done() {
			return finished;
		}

	}
	
	public class SendIntegersOnDemand extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour sends randomly chosen integers on demand of an agent, until that agent asks to stop. (EXO 4 TP 1)
		 *  
		 */

		private static final long serialVersionUID = 1L;

		private boolean finished=false;

		public SendIntegersOnDemand(final Agent myagent) {
			super(myagent);
		}


		public void action() {
			//Create a message in order to send it to the choosen agent
			final MessageTemplate msgTemplate = MessageTemplate.MatchPerformative(ACLMessage.INFORM);
			
			final ACLMessage msg = this.myAgent.receive(msgTemplate);
			if (msg != null) {
				final ACLMessage msgInt = new ACLMessage(ACLMessage.INFORM);
				msgInt.setSender(this.myAgent.getAID());
				Random rng = new Random();
				msgInt.addReceiver(new AID("AgentSum", AID.ISLOCALNAME));
				while (this.myAgent.receive(msgTemplate)==null){
					int n = rng.nextInt(100)+1;
					msgInt.setContent(Integer.toString(n));
					this.myAgent.send(msgInt);
					System.out.println("----> Message sent to AgentSum ,content= "+msgInt.getContent());
				}
			}
			else{
				block();
			}

		}

		public boolean done() {
			return finished;
		}

	}
}
