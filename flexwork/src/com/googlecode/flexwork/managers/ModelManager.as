package com.googlecode.flexwork.managers
{

	[Bindable]
	public class ModelManager implements IModelManager
	{

		public var cities:XML= //
			<xml>
				<globalVillage label="Global Village">
					<country label="United States">
						<state label="California" />
						<state label="Illinois" />				
						<state label="Texas" />					
						<state label="North Carolina" />					
						<state label="Florida" />										
						<state label="Maryland" />														
					</country>
					<country label="Singapore">
						<city label="Singapore City" />
					</country>
					<country label="China">
						<city label="Shanghai" />
						<city label="Beijing" />
						<city label="Shenzhen" />
						<city label="Hangzhou" />
						<city label="Dalian" />
					</country>
					<country label="India">
						<city label="Bangalore" />
						<city label="Hyderabad" />
						<city label="Chennai" />
						<city label="Delhi" />
						<city label="Ahmedabad" />
					</country>
					<country label="Germany">
						<city label="Hamburg" />
						<city label="Berlin" />
						<city label="Munich" />
						<city label="Stuttgart" />
						<city label="Ludwigshafen am Bodensee" />
					</country>
				</globalVillage>
			</xml>;


		public function ModelManager()
		{

		}
		public function getModel(name:String):* {
			return this[name];
		}

	}
}