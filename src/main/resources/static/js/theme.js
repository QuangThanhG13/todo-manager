/**
 * Theme toggling functionality
 */
(function() {
    // Initialize theme functionality when the DOM is fully loaded
    document.addEventListener('DOMContentLoaded', function() {
        initializeTheme();
    });
    
    // Initialize the theme functionality
    function initializeTheme() {
        // Get the saved theme from localStorage
        const savedTheme = localStorage.getItem('theme');
        
        // If there's a saved theme, apply it
        if (savedTheme) {
            document.documentElement.setAttribute('data-theme', savedTheme);
        }
        
        // Add click event to theme toggle
        const themeToggle = document.getElementById('theme-toggle');
        if (themeToggle) {
            themeToggle.addEventListener('click', toggleTheme);
        }
    }
    
    // Toggle between light and dark themes
    function toggleTheme() {
        // Get the current theme
        const currentTheme = document.documentElement.getAttribute('data-theme');
        
        // Switch to the opposite theme
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        // Update data-theme attribute
        document.documentElement.setAttribute('data-theme', newTheme);
        
        // Save the theme preference to localStorage
        localStorage.setItem('theme', newTheme);
    }
})(); 