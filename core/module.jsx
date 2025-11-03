// Example: Aura module structure
class AuraModule {
    constructor(name) {
        this.name = name;
        this.finalScore = 0;
        this.priority = 0;
    }

    updateScore(score) {
        this.finalScore = score;
        this.calculatePriority();
    }

    calculatePriority() {
        // Higher FinalScore = higher priority (1 = highest)
        this.priority = 10 - Math.round(this.finalScore * 10);
    }

    execute() {
        console.log(`${this.name} executing with priority ${this.priority}`);
        // Add module-specific behavior here
    }
}

// Initialize modules
const auraModules = {
    QuantumActivity: new AuraModule("QuantumActivity"),
    Sparks: new AuraModule("Sparks"),
    Teleportation: new AuraModule("Teleportation")
};

// Fetch SCTM JSON and update modules dynamically
fetch("/sctm_output.json")
    .then(res => res.json())
    .then(data => {
        data.forEach(module => {
            if(auraModules[module.name]){
                auraModules[module.name].updateScore(module.FinalScore);
                auraModules[module.name].execute();
            }
        });
    });
