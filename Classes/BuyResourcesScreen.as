package
{
	import flash.display.MovieClip;
		import flash.events.MouseEvent;

	public class BuyResourcesScreen extends MovieClip 
	{

		private var coins:Number;
		private var leftResources:Array;
		private var resources:Array;
		private var leftPayment:Array;
		private var rightPayment:Array;
		private var card:Card;
		
		private var resourceTexts:Array;
		private var greyresourceTexts:Array;
		
		private var plusminus:Array;
		private var greyplusminus:Array;
		
		private var selectedArray:Array;
		private var greyselectedArray:Array;
		
		private var textArray:Array;
		private var greytextArray:Array;
		
		private var maxResources:Array;
		private var greymaxResources:Array;
		
		private var checkedResources:Array;
		
		public function BuyResourcesScreen(buyDirection:String, myCoins:Number, neededResources:Array, theirResources:Array, payment:Array)
		{
			resourceTexts = new Array(resource1, resource2, resource3, resource4);
			greyresourceTexts = new Array(greyresource1, greyresource2, greyresource3);
			resource1.text = Game.brownResources[0];
			resource2.text = Game.brownResources[1];
			resource3.text = Game.brownResources[2];
			resource4.text = Game.brownResources[3];
			resources = theirResources;
			greyresource1.text = Game.greyResources[0];
			greyresource2.text = Game.greyResources[1];
			greyresource3.text = Game.greyResources[2];
			neighborDirectionText.text = buyDirection;
			
			checkedResources = new Array(resources.length);
			
			maxResources = [0,0,0,0];
			greymaxResources = [0,0,0];
			
			selectedArray = new Array(-1,-1,-1,-1);
			greyselectedArray = new Array(-1,-1,-1);
			
			plusminus = new Array(resource1plus,resource2plus,resource3plus,resource4plus,resource1minus,resource2minus,resource3minus,resource4minus);
			greyplusminus = new Array(greyresource1plus,greyresource2plus,greyresource3plus,greyresource1minus,greyresource2minus,greyresource3minus);
			
			
			textArray = new Array(resource1Amt,resource2Amt,resource3Amt,resource4Amt);
			greytextArray = new Array(greyresource1Amt,greyresource2Amt,greyresource3Amt);
			
			for(var j:int = 0; j < resourceTexts.length; j++){
					resourceTexts[j].visible = false;
					plusminus[j].visible = false;
					textArray[j].text = "";
					plusminus[j+resourceTexts.length].visible=false;
			}
			for(var j:int = 0; j < greyresourceTexts.length; j++){
					greyresourceTexts[j].visible = false;
					greyplusminus[j].visible = false;
					greytextArray[j].text = "";
					greyplusminus[j+greyresourceTexts.length].visible=false;
			}
			
			var resourceEnabled = [false, false, false, false];
			var greyresourceEnabled = [false, false, false];
			for(var i:int = 0; i < neededResources.length; i++){
				for(var j:int = 0; j < Game.brownResources.length; j++){
					if(neededResources[i]==Game.brownResources[j]&&(theirResources.indexOf(neededResources[i]>0))&&!resourceEnabled[j]){
					   		resourceTexts[j].visible = true;
							plusminus[j].visible = true;
							textArray[j].text = 0;
							resourceEnabled[j] = true;
							selectedArray[j] = 0;
							plusminus[j].addEventListener( MouseEvent.CLICK, onClickPlus(j) );
							plusminus[j+Game.brownResources.length].addEventListener( MouseEvent.CLICK, onClickMinus(j) );
					 }
				}
				for(var j:int = 0; j < Game.greyResources.length; j++){
					if(neededResources[i]==Game.greyResources[j]&&(theirResources.indexOf(neededResources[i]>0))&&!resourceEnabled[j]){
						
					   		greyresourceTexts[j].visible = true;
							greyplusminus[j].visible = true;
							greytextArray[j].text = 0;
							greyresourceEnabled[j] = true;
							greyselectedArray[j] = 0;
							greyplusminus[j].addEventListener( MouseEvent.CLICK, greyonClickPlus(j) );
							greyplusminus[j+Game.greyResources.length].addEventListener( MouseEvent.CLICK, greyonClickMinus(j) );
					 }
				}
				/*for(var j:int = 0; j < Game.greyResources.length; j++){
					if(neededResources[i]==Game.greyResources[j]&&(theirResources.indexOf(neededResources[i]>0))){
					   		greyResourceTexts[j].visible = true;
					 }
				}*/
				
			}
			updateStuff();

		}
		
		private function updateStuff():void{
			calculateMax();
			greycalculateMax();
			for(var i:int = 0; i < selectedArray.length; i++){
				if(selectedArray[i]==0) {
					textArray[i].text = selectedArray[i];
					plusminus[i+selectedArray.length].visible=false;
				} else if (selectedArray[i]>0) {
					textArray[i].text = selectedArray[i];
					plusminus[i+selectedArray.length].visible=true;
				}
				//can't subtract if we have 0 of it
				/*if(selectedNumber==total ||overUnique(i-1) || needToSelectOthers(i-1) || isOverMax(i-1)){
					plusminus[i-1+4].visible=false;
				} else {
					plusminus[i-1+4].visible=true;
				}*/
				//can't add if we are over total, are over unique and its 0, or are at our limit, or if we need to select others
			}
			for(var i:int = 0; i < greyselectedArray.length; i++){
				if(greyselectedArray[i]==0) {
					greytextArray[i].text = greyselectedArray[i];
					greyplusminus[i+greyselectedArray.length].visible=false;
				} else if (greyselectedArray[i]>0) {
					greytextArray[i].text = greyselectedArray[i];
					greyplusminus[i+greyselectedArray.length].visible=true;
				}
				//can't subtract if we have 0 of it
				/*if(selectedNumber==total ||overUnique(i-1) || needToSelectOthers(i-1) || isOverMax(i-1)){
					plusminus[i-1+4].visible=false;
				} else {
					plusminus[i-1+4].visible=true;
				}*/
				//can't add if we are over total, are over unique and its 0, or are at our limit, or if we need to select others
			}
			for(var i:int = 0; i < selectedArray.length; i++){
				if(selectedArray[i]>maxResources[i]) {
					textArray[i].text = selectedArray[i];
					plusminus[i].visible=false;
				}  else if (maxResources[i]==0&& selectedArray[i]>=0) {
					textArray[i].text = selectedArray[i];
					plusminus[i].visible=false;
				}else if (selectedArray[i]<maxResources[i] && selectedArray[i]>=0) {
					textArray[i].text = selectedArray[i];
					plusminus[i].visible=true;
				} 
				
			}
			for(var i:int = 0; i < greyselectedArray.length; i++){
				if(greyselectedArray[i]>greymaxResources[i]) {
					greytextArray[i].text = greyselectedArray[i];
					greyplusminus[i].visible=false;
				}  else if (greymaxResources[i]==0&& greyselectedArray[i]>=0) {
					greytextArray[i].text = greyselectedArray[i];
					greyplusminus[i].visible=false;
				}else if (greyselectedArray[i]<greymaxResources[i] && greyselectedArray[i]>=0) {
					greytextArray[i].text = greyselectedArray[i];
					greyplusminus[i].visible=true;
				} 
				
			}
			
			dispatchEvent( new GameEvent( GameEvent.ADDEDRESOURCE ) );

		}
		public function canAdd(i:int):Boolean{
			return (selectedArray[i]<maxResources[i] && selectedArray[i]>=0);
		}
		public function greycanAdd(i:int):Boolean{
			return (greyselectedArray[i]<greymaxResources[i] && greyselectedArray[i]>=0);
		}
		public function greydisablePlus(i:int):void{
			greyplusminus[i].visible=false;
		}
		public function greyenablePlus(i:int):void{
			greyplusminus[i].visible=true;
		}
		public function disablePlus(i:int):void{
			plusminus[i].visible=false;
		}
		public function enablePlus(i:int):void{
			plusminus[i].visible=true;
		}
		
		public function getResources():Array{
			var temp:Array = new Array();
			for(var i:int = 0; i < selectedArray.length; i++){
				for(var j:int = 0; j < selectedArray[i]; j++){
					temp.push(Game.brownResources[i]);
				}
			}
			return temp;
		}
		public function greygetResources():Array{
			var temp:Array = new Array();
			for(var i:int = 0; i < greyselectedArray.length; i++){
				for(var j:int = 0; j < greyselectedArray[i]; j++){
					temp.push(Game.greyResources[i]);
				}
			}
			return temp;
		}
		
		public function getSelectedArray():Array{
			return selectedArray;
		}
		public function greygetSelectedArray():Array{
			return greyselectedArray;
		}
		
		public function doneBuying():void{
			for(var i:int = 0; i < selectedArray.length; i++){
					plusminus[i].visible=false;
			}
			for(var i:int = 0; i < greyselectedArray.length; i++){
					greyplusminus[i].visible=false;
			}
		}
		
		public function onClickPlus( index:int ):Function{
			return function(mouseEvent:MouseEvent):void 
			{ 
				selectedArray[index]++;
				var marked:Boolean = false;
				for(var i:int = 0; i < resources.length; i++){
					if(checkedResources[i]!=1){
						if(resources[i].indexOf(Game.brownResources[index])>=0&&resources[i].indexOf("/")==-1){
							checkedResources[i] = 1;
							marked = true;
							break;
						}
					}
				}
				if(!marked){
					for(var i:int = 0; i < resources.length; i++){
						if(checkedResources[i]!=1){
							if(resources[i].indexOf(Game.brownResources[index])>=0){
								checkedResources[i] = 1;
								break;
							}
						}
					}
				}
				updateStuff();
			}
		}
		
		public function greyonClickPlus( index:int ):Function{
			return function(mouseEvent:MouseEvent):void 
			{ 
				greyselectedArray[index]++;
				var marked:Boolean = false;
				for(var i:int = 0; i < resources.length; i++){
					if(checkedResources[i]!=1){
						if(resources[i].indexOf(Game.greyResources[index])>=0&&resources[i].indexOf("/")==-1){
							checkedResources[i] = 1;
							marked = true;
							break;
						}
					}
				}
				if(!marked){
					for(var i:int = 0; i < resources.length; i++){
						if(checkedResources[i]!=1){
							if(resources[i].indexOf(Game.greyResources[index])>=0){
								checkedResources[i] = 1;
								break;
							}
						}
					}
				}
				updateStuff();
			}
		}
		
		public function calculateMax():void{
			maxResources = [0,0,0,0];
			for(var i:int = 0; i < resources.length; i++){
				if(checkedResources[i]!=1){
					for(var j:int = 0; j < Game.brownResources.length; j++){
						if(resources[i].indexOf(Game.brownResources[j])>=0){
							maxResources[j]++;
						}
					}
				}
			}
		}
		
		public function greycalculateMax():void{
			greymaxResources = [0,0,0,0];
			for(var i:int = 0; i < resources.length; i++){
				if(checkedResources[i]!=1){
					for(var j:int = 0; j < Game.greyResources.length; j++){
						if(resources[i].indexOf(Game.greyResources[j])>=0){
							greymaxResources[j]++;
						}
					}
				}
			}
		}
		
		
		public function onClickMinus( index:int ):Function{
			return function(mouseEvent:MouseEvent):void 
			{ 
				selectedArray[index]--;
				var marked:Boolean = false;
				for(var i:int = 0; i < resources.length; i++){
					if(checkedResources[i]==1){
						if(resources[i].indexOf(Game.brownResources[index])>=0&&resources[i].indexOf("/")>0){
							checkedResources[i] = -1;
							marked = true;
							break;
						}
					}
				}
				if(!marked){
					for(var i:int = 0; i < resources.length; i++){
						if(checkedResources[i]==1){
							if(resources[i].indexOf(Game.brownResources[index])>=0){
								checkedResources[i] = -1;
								break;
							}
						}
					}
				}
				updateStuff();
			}
		}
		
		public function greyonClickMinus( index:int ):Function{
			return function(mouseEvent:MouseEvent):void 
			{ 
				greyselectedArray[index]--;
				var marked:Boolean = false;
				for(var i:int = 0; i < resources.length; i++){
					if(checkedResources[i]==1){
						if(resources[i].indexOf(Game.greyResources[index])>=0&&resources[i].indexOf("/")>0){
							checkedResources[i] = -1;
							marked = true;
							break;
						}
					}
				}
				if(!marked){
					for(var i:int = 0; i < resources.length; i++){
						if(checkedResources[i]==1){
							if(resources[i].indexOf(Game.greyResources[index])>=0){
								checkedResources[i] = -1;
								break;
							}
						}
					}
				}
				updateStuff();
			}
		}
		
		
	}
}