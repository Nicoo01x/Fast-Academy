var B = {
	
	action: false,
	
	start: function(time, text, color)
    {
		if (B.action)
		{
			console.log("You are already using something.");
			return;
		}
		B.action = true;
		
		progress.style.width = "350px";
		progress.innerHTML = B.tmp(text, color);
		
		var p = 0;
		var iv = setInterval(function()
		{
			p++;
			progress_bar.style.width = p + "%";
			progress_precent.innerText = p + "%";
			
			if(p == 100)
			{
				clearInterval(iv);
				
				setTimeout(function()
				{					
					progress.style.width = "0px";
					progress_text.style.opacity = 0;
					B.action = false;
					B.onPostCallback(`https://progressBar/completedBar`, JSON.stringify({}));
				}, 800)
			}
		}, time * 10);
	},
	
	tmp: function(text, color)
	{
		return `	<div id="progress_bar" class="progress_bar" style="background-color: ${color}; box-shadow: 2px 2px 4px ${color}, 0 0 2px ${color}">
					<div class="stripes"></div>
					<div id="progress_text" class="progress_text">
						<div style="width: 10px"></div>
						<div>${text}:</div>
						<div style="width: 5px"></div>
						<div id="progress_precent">0%</div>
					</div>
				</div>`;
	},
	
	onDisplay: function()
    {
		window.addEventListener('message', (event) => 
		{
			let item = event.data;
			B.start(item.timer, item.text, item.color);
		});
    },
	    
    onPostCallback: function(nui, postbody)
    {
        fetch(nui,{
            method: 'POST',
            headers: {'Content-Type': 'application/json; charset=UTF-8',
			},
            body: postbody
		})
    }
};