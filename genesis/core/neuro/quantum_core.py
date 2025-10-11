from qiskit import QuantumCircuit, Aer, execute
import random
from core.shared.utils import AuraLogger

logger = AuraLogger("QuantumCore")

class QuantumCore:
    """Generates quantum-inspired mini-circuits for reasoning and intuition"""
    def __init__(self):
        self.logger = logger

    def generate_circuit(self):
        qubits = random.randint(2, 4)
        qc = QuantumCircuit(qubits)

        # Apply random gates
        for q in range(qubits):
            gate = random.choice(['h','x','y','z'])
            getattr(qc, gate)(q)

        # Entangle some qubits
        if qubits > 2:
            qc.cx(0, 1)

        self.logger.info(f"⚡ Quantum circuit generated with {qubits} qubits")
        return qc

    def run_circuit(self, qc):
        simulator = Aer.get_backend('statevector_simulator')
        result = execute(qc, simulator).result()
        statevector = result.get_statevector()
        self.logger.info(f"🌀 Circuit statevector: {statevector}")
        return statevector
