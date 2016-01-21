
import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.SimpleBehaviour;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;


public class AgentReceiver extends Agent{
	
	protected void setup(){

		super.setup();

		//get the parameters given into the object[]
		final Object[] args = getArguments();
		if(args.length!=0){
			System.out.println("Erreur lors de la creation du receveur");

		}

		//Add the behaviours
		//Ex1
		//addBehaviour(new ReceiveMessage(this));
		
		//Ex2
		//addBehaviour(new Receive10Integers(this));
		
		//Ex3
		addBehaviour(new ReceiveXIntegers(this));
		
		
		System.out.println("the receiver agent "+this.getLocalName()+ " is started");

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

	public class ReceiveMessage extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour is the first step of the paxos
		 *  
		 */
		private static final long serialVersionUID = 9088209402507795289L;

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
				System.out.println("<----Message received from "+msg.getSender()+" ,content= "+msg.getContent());
				this.finished=true;
			}else{
				System.out.println("Receiver - No message received");
			}
		}

		public boolean done() {
			return finished;
		}

	}
	
	
	public class Receive10Integers extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour is part of Ex2TP1
		 *  
		 */
		private static final long serialVersionUID = 908820940250775289L;

		private boolean finished=false;
		
		private int compteur=0;
		
		private int sum = 0;

		public Receive10Integers(final Agent myagent) {
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
				System.out.println("<----Message received from "+msg.getSender().getLocalName()+" ,content= "+msg.getContent());
				compteur++;
				sum+=Integer.parseInt(msg.getContent());
			}
			
			if(compteur == 10)
			{
				final ACLMessage answer = new ACLMessage(ACLMessage.INFORM);
				answer.setSender(this.myAgent.getAID());
				answer.addReceiver(new AID("Agent0", AID.ISLOCALNAME));
				answer.setContent(Integer.toString(sum));
				this.myAgent.send(answer);
				System.out.println("Sum sent");
				this.finished = true;
			}
		}

		public boolean done() {
			return finished;
		}

	}
	
	public class ReceiveXIntegers extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour is part of Ex3TP1
		 *  
		 */
		private static final long serialVersionUID = 908820940250775289L;

		private boolean finished=false;
		
		private int compteur0=0;
		private int sum0 = 0;
		boolean sent0 = false;
			
		private int compteur2=0;
		private int sum2 = 0;
		boolean sent2 = false;

		public ReceiveXIntegers(final Agent myagent) {
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
				System.out.println("<----Message received from "+msg.getSender().getLocalName()+" ,content= "+msg.getContent());
				if(msg.getSender().getLocalName().equals("Agent0"))
				{
					compteur0++;
					sum0+=Integer.parseInt(msg.getContent());
				}
				else if(msg.getSender().getLocalName().equals("Agent2"))
				{
					compteur2++;
					sum2+=Integer.parseInt(msg.getContent());
				}
			}
			
			if(compteur0 == 10 && !sent0)
			{
				final ACLMessage answer = new ACLMessage(ACLMessage.INFORM);
				answer.setSender(this.myAgent.getAID());
				answer.addReceiver(new AID("Agent0", AID.ISLOCALNAME));
				answer.setContent(Integer.toString(sum0));
				this.myAgent.send(answer);
				System.out.println("Sum sent to Agent0");
				sent0 = true;
			}
			
			if(compteur2 == 15 && !sent2)
			{
				final ACLMessage answer = new ACLMessage(ACLMessage.INFORM);
				answer.setSender(this.myAgent.getAID());
				answer.addReceiver(new AID("Agent2", AID.ISLOCALNAME));
				answer.setContent(Integer.toString(sum2));
				this.myAgent.send(answer);
				System.out.println("Sum sent to Agent2");
				sent2 = true;
			}
			
			if(compteur0 == 10 && compteur2 == 15)
				this.finished = true;
		}

		public boolean done() {
			return finished;
		}

	}

}
