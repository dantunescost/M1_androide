import java.util.List;

import jade.core.AID;
import jade.core.Agent;
import jade.core.behaviours.SimpleBehaviour;
import jade.lang.acl.ACLMessage;
import jade.lang.acl.MessageTemplate;


public class AgentSomme extends Agent{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public int K;
	protected List<String> data;
	
	protected void setup(){

		super.setup();
		//get the parameters given into the object[]
		final Object[] args = getArguments();
		if(args.length!=0){
			data = (List<String>) args[0];
			K = Integer.parseInt(data.get(0));
		}
		//EX4
		addBehaviour(new ReceiveKIntegers(this));
		
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
	
	
	public class ReceiveKIntegers extends SimpleBehaviour{
		/**
		 * When an agent choose to communicate with others agents in order to reach a precise decision, 
		 * it tries to form a coalition. This behaviour is part of Ex2TP1
		 *  
		 */
		private static final long serialVersionUID = 908820940250775289L;

		private boolean finished=false;
		
		private int compteur=0;
		
		private int sum = 0;
		
		private boolean demandSent = false;
		

		public ReceiveKIntegers(final Agent myagent) {
			super(myagent);

		}


		public void action() {
			if(!demandSent){
				//1) send demand to every other agent
				final ACLMessage demand = new ACLMessage(ACLMessage.INFORM);
				demand.setSender(this.myAgent.getAID());
				demand.addReceiver(new AID("Agent0", AID.ISLOCALNAME));
				demand.addReceiver(new AID("Agent1", AID.ISLOCALNAME));
				demand.addReceiver(new AID("Agent2", AID.ISLOCALNAME));
				demand.addReceiver(new AID("Agent3", AID.ISLOCALNAME));
				demand.setContent("Demand for "+K+" integers!");
				this.myAgent.send(demand);
				demandSent = true;
			}
			
			//2) receive the message
			final MessageTemplate msgTemplate = MessageTemplate.MatchPerformative(ACLMessage.INFORM);
			

			final ACLMessage msg = this.myAgent.receive(msgTemplate);
			if (msg != null) {		
				System.out.println("<----Message received from "+msg.getSender().getLocalName()+" ,content= "+msg.getContent());
				compteur++;
				sum+=Integer.parseInt(msg.getContent());
			}
			
			if(compteur == K)
			{
				final ACLMessage answer = new ACLMessage(ACLMessage.INFORM);
				answer.setSender(this.myAgent.getAID());
				answer.addReceiver(new AID("Agent0", AID.ISLOCALNAME));
				answer.addReceiver(new AID("Agent1", AID.ISLOCALNAME));
				answer.addReceiver(new AID("Agent2", AID.ISLOCALNAME));
				answer.addReceiver(new AID("Agent3", AID.ISLOCALNAME));
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

}