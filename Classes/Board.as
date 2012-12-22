package 
{
		import flash.display.MovieClip;
		import flash.display.Bitmap;
		import flash.display.BitmapData;
		import flash.events.MouseEvent;
		import flash.utils.getDefinitionByName;
	public class Board extends MovieClip 
	{
		private var boardName:String;
		private var resource:String;
		private var wonderStages:Array;
		private var currentStage:int;
		
		
 		public function Board(givenName:String, freeResource:String, stage1:WonderStage = null, stage2:WonderStage = null, stage3:WonderStage = null, stage4:WonderStage = null) 
		{
			boardName = givenName;
			x = 400;
			y = 350;
			this.resource = freeResource;
			makeImage(givenName);
			wonderStages = new Array();
			if(stage1!= null) wonderStages.push(stage1);
			if(stage2!= null) wonderStages.push(stage2);
			if(stage3!= null) wonderStages.push(stage3);
			if(stage4!= null) wonderStages.push(stage4);
			trace(givenName + "'s wonder stages are " + wonderStages);
			currentStage = 0;
		}
		
		public function getName():String{
			return boardName;
		}
		
		public function getResource():String{
			return resource;
		}
		
		public function getWonderStages():Array{
			return wonderStages;
		}
		
		public function getCurrentStage():int{
			return currentStage;
		}
		
		public function getNextStage():WonderStage{
			if(currentStage > wonderStages.length) return null;
			return wonderStages[currentStage];
		}
		
		public function getStageX():Number{
			return (currentStage * 100) + this.x+30;
		}
		public function getStageY():Number{
			return  this.y+50;
		}
		
		public function updateStage():void{
			currentStage++;
		}
		protected function makeImage(file:String):void {
			//var image;
			/*switch (file) {
				case "firecard" :
					image=new lumbermill(0,0);
					break;
				case "RedCard" :
					image=new redcard(0,0);
					break;
				case "BlueCard" :
					image=new bluecard(0,0);
					break;
				case "GreenCard" :
					image=new greencard(0,0);
					break;
				case "BlackCard" :
					image=new blackcard(0,0);
					break;
				default :
					image=new greycard(0,0);
			}
			*/
			var imageString:String = file;
			var ClassReference:Class = getDefinitionByName(imageString) as Class;
			var classInstance:BitmapData;
  			classInstance = new ClassReference (0,0) as BitmapData;
			var bitmap:Bitmap=new Bitmap(classInstance);

			//var bitmap:Bitmap=new Bitmap(image);
			addChild(bitmap);
		}

	}
}