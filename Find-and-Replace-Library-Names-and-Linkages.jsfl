function find_and_replace_in_library(){ 
	
	var substitute=prompt('What is the word to substitute?');
	var newterm=prompt('By which word?');
	if(substitute==null || newterm==null){
		return;
	}
	
	for( var h = 0; h < fl.getDocumentDOM().library.items.length; h++){
		var item=fl.getDocumentDOM().library.items[h];
		
		//search for item name
		var full_item_name=item.name;
		var item_folder=full_item_name.substr(0,full_item_name.lastIndexOf('/'));
		var clean_item_name=full_item_name.substr(full_item_name.lastIndexOf('/')+1);	
		var old_name=clean_item_name;
		var new_name='';
		var exploded=old_name.split(substitute);
		for(var i=0; i<exploded.length; i++){
			if(i!=0){
				new_name+=newterm;
			}
			new_name+=exploded[i];
		}
		if(old_name!=new_name){
			item.name=new_name;
		}
		
		//search for linkage
		if(item.itemType=='movie clip'){
			if(item.linkageClassName!='' && item.linkageClassName!=undefined && item.linkageClassName!=null){
				var old_name=item.linkageClassName;
				var new_name='';
				var exploded=old_name.split(substitute);
				for(var i=0; i<exploded.length; i++){
					if(i!=0){
						new_name+=newterm;
					}
					new_name+=exploded[i];
				}
				if(old_name!=new_name){
					item.linkageClassName=new_name;
				}
			}
		}
	}
}

find_and_replace_in_library();

