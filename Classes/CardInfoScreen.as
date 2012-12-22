package
{
	import flash.display.MovieClip;
	import flash.text.*;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;


	public class CardInfoScreen extends MovieClip 
	{

		private var coins:Number;
		private var leftResources:Array;
		private var resources:Array;
		private var rightResources:Array;
		private var leftPayment:Array;
		private var rightPayment:Array;
		private var card:Card;
		private var leftResourceScreen:BuyResourcesScreen;
		private var rightResourceScreen:BuyResourcesScreen;
		private var totalCost:int;
		private var wonderStage:WonderStage;
		
		public function CardInfoScreen(c:Card)
		{
			payBuildButton.mouseEnabled = false;
			payWonderBuild.visible = false;
			buildWonderButton.visible = false;
			doneBuyingButton.visible = false;
			
			totalCost = c.getCoinCost();
			costAmt.text = totalCost.toString();
			card = c;
			buildButton.mouseEnabled = false;
			buildWonderButton.visible = false;
			
			closeButton.addEventListener( MouseEvent.CLICK, closeWindow );
			discardButton.addEventListener( MouseEvent.CLICK, discard );
			resourceCost.text = c.getCost().toString();
			tooExpensive.visible=false;
			var bigCard:Bitmap;
			bigCard =  c.getNewBigImage();
			bigCard.x = 170.3;
			bigCard.y = 41.30;
			addChild(bigCard);
		}
		
		public function closeWindow( mouseEvent:MouseEvent ):void{
			dispatchEvent( new GameEvent( GameEvent.OOPS ) );
			dispatchEvent( new NavigationEvent( NavigationEvent.closeCardInfo ) );
		}
		public function build( c:Card ):Function{
			return function(e:MouseEvent){
				if(c.getColor() != "none"){
			dispatchEvent( new GameEvent( GameEvent.BUILD ) );
			dispatchEvent( new NavigationEvent( NavigationEvent.closeCardInfo ) );
				}
				else{
					trace("BUILT WONDER");
					dispatchEvent( new GameEvent( GameEvent.BUILDWONDER ) );
			dispatchEvent( new NavigationEvent( NavigationEvent.closeCardInfo ) );
				}
			}
		}
		public function discard( mouseEvent:MouseEvent ):void{
			dispatchEvent( new GameEvent( GameEvent.DISCARD ) );
			dispatchEvent( new NavigationEvent( NavigationEvent.closeCardInfo ) );
		}
		public function enableBuild( ):void{
			buildButton.mouseEnabled = true;
			payBuildButton.visible = false;
			payBuildButton.mouseEnabled = false;
			buildButton.addEventListener( MouseEvent.CLICK, build(card) );
		}
		public function enableWonderBuild( ):void{
			buildWonderButton.visible = true;
			buildWonderButton.addEventListener( MouseEvent.CLICK, build(wonderStage) );
		}
		public function enablePayBuild(myResources:Array, myCoins:Number, leftRes:Array, leftPay:Array, rightRes:Array, rightPay:Array ):void{
			payBuildButton.mouseEnabled = true;
			buildButton.visible = false;
			doneBuyingButton.visible = false;
			buildButton.mouseEnabled = false;
			resources = myResources;
			coins = myCoins;
			leftResources = leftRes;
			leftPayment = leftPay;
			rightResources = rightRes;
			rightPayment = rightPay;
			payBuildButton.addEventListener( MouseEvent.CLICK, paybuild(card) );
			doneBuyingButton.addEventListener( MouseEvent.CLICK, build(card) );
		}
		
		public function enablePayWonderBuild(myResources:Array, myCoins:Number, leftRes:Array, leftPay:Array, rightRes:Array, rightPay:Array ):void{
			payWonderBuild.visible = true;
			doneBuyingButton.visible = false;
			resources = myResources;
			coins = myCoins;
			leftResources = leftRes;
			leftPayment = leftPay;
			rightResources = rightRes;
			rightPayment = rightPay;
			payWonderBuild.addEventListener( MouseEvent.CLICK, paybuild(wonderStage) );
			doneBuyingButton.addEventListener( MouseEvent.CLICK, build(wonderStage) );
		}
		

		public function paybuild( c:Card):Function{
			return function(e:MouseEvent):void{
			payBuildButton.mouseEnabled = false;
			leftResourceScreen = new BuyResourcesScreen("Left", coins, leftNeighborNeededResources(c), leftResources, leftPayment);
			leftResourceScreen.x = -400;
			leftResourceScreen.addEventListener(GameEvent.ADDEDRESOURCE, refreshBoards(c));
			addChild(leftResourceScreen);
			rightResourceScreen = new BuyResourcesScreen("Right", coins, rightNeighborNeededResources(c), rightResources, rightPayment);
			rightResourceScreen.x = 400;
			rightResourceScreen.addEventListener(GameEvent.ADDEDRESOURCE, refreshBoards(c));
			addChild(rightResourceScreen);
			rightResources.x = 600;
																		  //for each oft he resources
																		  //if i buy that resource, can i afford the card
																		  //so pretend to buy that resource at that price and see if you can still build the card
																		  //if not, then gray out the resource
			}
		}
		
		public function setWonderStage(c:WonderStage):void{
			this.wonderStage = c;
		}
		public function refreshBoards(clickedCard:Card):Function{
			return function (e:GameEvent):void{
				var c:Card = clickedCard;
			var cardCosts:Array = [0,0,0,0];
			var greycardCosts:Array = [0,0,0];
			var cardCostArray = c.getCost();
			for(var i:int = 0; i < cardCostArray.length; i++){
				for(var j:int = 0; j < Game.brownResources.length; j++){
					if(cardCostArray[i]==Game.brownResources[j]){
						cardCosts[j]++;
						break;
					}
				}
				for(var j:int = 0; j < Game.greyResources.length; j++){
					if(cardCostArray[i]==Game.greyResources[j]){
						greycardCosts[j]++;
						break;
					}
				}
			}
			var leftSelected = leftResourceScreen.getSelectedArray();
			var rightSelected = rightResourceScreen.getSelectedArray();
			var greyleftSelected = leftResourceScreen.greygetSelectedArray();
			var greyrightSelected = rightResourceScreen.greygetSelectedArray();
			for(var i:int = 0; i < cardCosts.length; i++){
				if(leftSelected[i]!= -1){
				cardCosts[i] = cardCosts[i] - leftSelected[i];
				}
				if(rightSelected[i]!= -1){
				cardCosts[i] = cardCosts[i] - rightSelected[i];
				}
				if(leftResourceScreen.canAdd(i)){
					leftResourceScreen.enablePlus(i);
				}
				if(rightResourceScreen.canAdd(i)){
					rightResourceScreen.enablePlus(i);
				}
				if(cardCosts[i] == 0){
					leftResourceScreen.disablePlus(i);
					rightResourceScreen.disablePlus(i);
				}
			}
			for(var i:int = 0; i < greycardCosts.length; i++){
				if(greyleftSelected[i]!= -1){
				greycardCosts[i] = greycardCosts[i] - greyleftSelected[i];
				}
				if(rightSelected[i]!= -1){
				greycardCosts[i] = greycardCosts[i] - greyrightSelected[i];
				}
				if(leftResourceScreen.greycanAdd(i)){
					leftResourceScreen.greyenablePlus(i);
				}
				if(rightResourceScreen.greycanAdd(i)){
					rightResourceScreen.greyenablePlus(i);
				}
				if(greycardCosts[i] == 0){
					leftResourceScreen.greydisablePlus(i);
					rightResourceScreen.greydisablePlus(i);
				}
			}
			trace("The card cost is " + cardCosts);
			checkforBuild(c);
			}
		}
		
		public function checkforBuild(c:Card):void{
			var cardToBuy:Card = c;
			var buyFromLeft:Array = leftResourceScreen.getResources();
			var buyFromRight:Array = rightResourceScreen.getResources();
			var greybuyFromLeft:Array = leftResourceScreen.greygetResources();
			var greybuyFromRight:Array = rightResourceScreen.greygetResources();
			var buyFromLeftCheck:Array = new Array(buyFromLeft.length);
			var buyFromRightCheck:Array = new Array(buyFromRight.length);
			var greybuyFromLeftCheck:Array = new Array(greybuyFromLeft.length);
			var greybuyFromRightCheck:Array = new Array(greybuyFromRight.length);
			var canBuy:Boolean = true;
			var res = resources;
			var checkedRes:Array = new Array(res.length);
			var costChecked:Array = new Array(cardToBuy.getCost().length);
			var coinCost:int = 0;
			var built:Boolean = false;
			for(var i:int =0; i<cardToBuy.getCost().length; i++){
				for(var j:int =0; j<res.length; j++){
					if(res[j].indexOf(cardToBuy.getCost()[i])>-1 && checkedRes[j]!=1 && res[j].indexOf("/")==-1){
						checkedRes[j] = 1;
						built = true;
						break;
					}
				}
				if(built == false){
					for(var j:int =0; j<buyFromLeft.length; j++){
						if(buyFromLeft[j].indexOf(cardToBuy.getCost()[i])>-1 && buyFromLeftCheck[j]!=1){
							buyFromLeftCheck[j] = 1;
							coinCost+=getPayment(leftPayment, cardToBuy.getCost()[i]);
							built = true;
							break;
						}
					}
					for(var j:int =0; j<greybuyFromLeft.length; j++){
						if(greybuyFromLeft[j].indexOf(cardToBuy.getCost()[i])>-1 && greybuyFromLeftCheck[j]!=1){
							greybuyFromLeftCheck[j] = 1;
							coinCost+=getPayment(leftPayment, cardToBuy.getCost()[i]);
							built = true;
							break;
						}
					}
				}
				if(built == false){
					for(var j:int =0; j<buyFromRight.length; j++){
						if(buyFromRight[j].indexOf(cardToBuy.getCost()[i])>-1 && buyFromRightCheck[j]!=1){
							buyFromRightCheck[j] = 1;
							coinCost+=getPayment(rightPayment, cardToBuy.getCost()[i]);
							built = true;
							break;
						}
					}
					for(var j:int =0; j<greybuyFromRight.length; j++){
						if(greybuyFromRight[j].indexOf(cardToBuy.getCost()[i])>-1 && greybuyFromRightCheck[j]!=1){
							greybuyFromRightCheck[j] = 1;
							coinCost+=getPayment(rightPayment, cardToBuy.getCost()[i]);
							built = true;
							break;
						}
					}
				}
				if(built == false){
					for(var j:int =0; j<res.length; j++){
						if(res[j].indexOf(cardToBuy.getCost()[i])>-1 && checkedRes[j]!=1){
							checkedRes[j] = 1;
							trace("I can buy a " + cardToBuy.getCost()[i]);
							built = true;
							break;
						}
					}
				}
				if(coins<coinCost){
					tooExpensive.visible=true;
					built = false;
				} else{
					tooExpensive.visible=false;
				}
				if(built == false){
					doneBuyingButton.visible = false;
					canBuy = false;
					break;
				}
				built = false;
			}
			totalCost = coinCost;
			costAmt.text = coinCost.toString();
			if(canBuy){
				leftResourceScreen.doneBuying();
				rightResourceScreen.doneBuying();
				doneBuyingButton.visible = true;
			}
		}
		
		private function getPayment(paymentArray:Array, resource:String):int{
			for(var i:int = 0; i < Game.brownResources.length; i++){
				if(Game.brownResources[i]==resource){
					return paymentArray[0];
				}
			}
			return paymentArray[1];
		}
		
		private function leftNeighborNeededResources(c:Card):Array{
			var temp:Array = new Array();
			var cardToBuy:Card = c;
			var res = resources;
			var checkedRes:Array = new Array(res.length);
			var costChecked:Array = new Array(cardToBuy.getCost().length);
			var leftRes = leftResources;
			var rightRes = rightResources;
			var leftCheckedRes:Array = new Array(leftResources.length);
			var built:Boolean = false;
			for(var i:int =0; i<cardToBuy.getCost().length; i++){
				for(var j:int =0; j<res.length; j++){
					if(res[j].indexOf(cardToBuy.getCost()[i])>-1 && !hasOtherResources(res[j], cardToBuy.getCost(), cardToBuy.getCost()[i]) && checkedRes[j]!=1){
						checkedRes[j] = 1;
						costChecked[i] = 1;
						built = true;
						break;
					}
				}
				if(built == false){
					for(var j:int = 0; j<leftRes.length; j++){
						if(leftRes[j].indexOf(cardToBuy.getCost()[i])>-1 && leftCheckedRes[j]!=1 && !arrayContainsResource(rightRes, cardToBuy.getCost()[i])){
							if(hasOtherResources(leftRes[j], cardToBuy.getCost(), cardToBuy.getCost()[i])){
							   
							}else{
							leftCheckedRes[j] = 1;
							costChecked[i] = 1;
							}
							trace(" ok adding " + cardToBuy.getCost()[i] + " first");
							temp.push(cardToBuy.getCost()[i]);
							break;
						}
					}
				}
				built = false;
			}
			for(var i:int = 0; i<cardToBuy.getCost().length; i++){
				if(costChecked[i]!=1){
					for(var j:int = 0; j<leftRes.length; j++){
						if(leftRes[j].indexOf(cardToBuy.getCost()[i])>-1 && leftCheckedRes[j]!=1){
							if(!hasOtherResources(leftRes[j], cardToBuy.getCost(), cardToBuy.getCost()[i])){
							leftCheckedRes[j] = 1;
							costChecked[i] = 1;
							   }
							  trace(" ok adding " + cardToBuy.getCost()[i] + " 2nd");
							temp.push(cardToBuy.getCost()[i]);
							break;
						}
					}
				}
			}
			trace("I need "  + temp + " from left");
			return temp;
		
		}
		
		private function hasOtherResources(resourceCard:String, cardResources:Array, notThis:String):Boolean{
			for(var i:int=0; i<cardResources.length; i++){
				if(cardResources[i]!=notThis && resourceCard.indexOf(cardResources[i])>-1){
					return true;
				}
			}
			return false;
		}
		
		private function arrayContainsResource(resources:Array, resource:String):Boolean{
			for(var i:int =0; i<resources.length; i++){
				if(resources[i].indexOf(resource)>-1){
						return true;
				}
			}
			return false;
		}
		public function getCost():int{
			return totalCost;
		}
		private function rightNeighborNeededResources(c:Card):Array{
			var cardToBuy:Card = c;
			var temp:Array = new Array();
			var res = resources;
			var checkedRes:Array = new Array(res.length);
			var costChecked:Array = new Array(cardToBuy.getCost().length);
			var rightRes = rightResources;
			var leftRes = leftResources;
			var rightCheckedRes:Array = new Array(rightResources.length);
			var built:Boolean = false;
			for(var i:int = 0; i<cardToBuy.getCost().length; i++){
				for(var j:int = 0; j<res.length; j++){
					if(res[j].indexOf(cardToBuy.getCost()[i])>-1 && checkedRes[j]!=1){
						checkedRes[j] = 1;
						costChecked[i] = 1;
						built = true;
						break;
					}
				}
				if(built == false){
					for(var j:int = 0; j<rightRes.length; j++){
						if(rightRes[j].indexOf(cardToBuy.getCost()[i])>-1 && rightCheckedRes[j]!=1 && !arrayContainsResource(leftRes, cardToBuy.getCost()[i])){
							rightCheckedRes[j] = 1;
							costChecked[i] = 1;
														 trace(" ok adding " + cardToBuy.getCost()[i] + " 1st right");
							temp.push(cardToBuy.getCost()[i]);
							break;
						}
					}
				}
				built = false;
			}
			for(var i:int = 0; i<cardToBuy.getCost().length; i++){
				if(costChecked[i]!=1){
					for(var j:int = 0; j<rightRes.length; j++){
						if(rightRes[j].indexOf(cardToBuy.getCost()[i])>-1 && rightCheckedRes[j]!=1){
							rightCheckedRes[j] = 1;
							costChecked[i] = 1;
							 trace(" ok adding " + cardToBuy.getCost()[i] + " 2nd right");
							temp.push(cardToBuy.getCost()[i]);
							break;
						}
					}
				}
			}
			trace("I need "  + temp + " from right");
			return temp;
		}
	}
}