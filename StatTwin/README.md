StatTwin is an IOS App that can compute your most similar NBA Player, as well as any current NBA player's statistical twin!

The app contains 3 main views. The self input view, the player input view, and the result view.

For the self input view, you can either input your stats through dragging sliders or directly entering them with a decimal key pad. Toggle between text or slider with the button at the top right of the screen!

<img width="203" height="334" alt="Screenshot 2025-11-23 at 4 16 15 PM" src="https://github.com/user-attachments/assets/efed303a-ae6e-4424-8ed1-776d75b66942" />
<img width="203" height="334" alt="Screenshot 2025-11-23 at 4 16 29 PM" src="https://github.com/user-attachments/assets/5ef5b400-21bd-47c4-a204-c6fb9c3f6dc3" />
<br>
Once you are done entering in your stats, you can view your player card at the bottom!
<br>
<img width="221" height="454" alt="Screenshot 2025-11-23 at 4 17 25 PM" src="https://github.com/user-attachments/assets/9f605bb9-9d75-43dc-9b99-925a4ac92e41" />
<br>

For the player input view, simply search or scroll to your desired player, and select them
<br>
<img width="197" height="435" alt="Screenshot 2025-11-23 at 4 20 17 PM" src="https://github.com/user-attachments/assets/b126bdd9-34a0-4ac8-99a6-d90fa19e6678" />

After doing your desired method of input, you view your results!
<br>
<img width="220" height="447" alt="Screenshot 2025-11-23 at 4 21 03 PM" src="https://github.com/user-attachments/assets/98cc576c-fc10-4dfd-a59b-5749f6dd6d94" />
<br>
The method I used to calculate similarity
	1. Scale each player's stats using z score standardization
	2. Weight each player's attributes
	3. Use both vector projection and euclidean distance to measure how similar each player's stats are to the inputted player
