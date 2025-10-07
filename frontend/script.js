document.addEventListener('DOMContentLoaded', () => {
    
    const VOTE_API_ENDPOINT = 'https://oyvdckcb5m.execute-api.eu-central-1.amazonaws.com/vote'; 

    const pollContainer = document.getElementById('poll-container');
    const resultsContainer = document.getElementById('results-container');
    const voteResult = document.getElementById('vote-result');
    const backToPollButton = document.getElementById('back-to-poll');
    const options = document.querySelectorAll('.option');
    const loadingSpinner = document.getElementById('loading-spinner');

    options.forEach(button => {
        button.addEventListener('click', async (event) => {
            const pollId = event.target.dataset.pollId;
            const optionId = event.target.dataset.optionId;

            showLoading(true);
            
            try {
                const response = await fetch(VOTE_API_ENDPOINT, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify({
                        poll_id: pollId,
                        option_id: optionId
                    }),
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                
                const result = await response.json();
                
                showLoading(false);
                displayResults(result);

            } catch (error) {
                console.error('Error submitting vote:', error);
                showLoading(false);
                alert('Could not submit your vote. Please try again.');
            }
        });
    });

    backToPollButton.addEventListener('click', () => {
        resultsContainer.style.display = 'none';
        pollContainer.style.display = 'block';
    });

    function displayResults(result) {
        pollContainer.style.display = 'none';
        resultsContainer.style.display = 'block';
        voteResult.textContent = `Thank you for your vote! Your vote ID is: ${result.vote.vote_id}`;
    }

    function showLoading(isLoading) {
        if (isLoading) {
            pollContainer.style.display = 'none';
            resultsContainer.style.display = 'none';
            loadingSpinner.style.display = 'block';
        } else {
            loadingSpinner.style.display = 'none';
        }
    }
});