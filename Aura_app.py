import streamlit as st
import pandas as pd
import plotly.express as px
import joblib
import os
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from qiskit import QuantumCircuit
from qiskit_aer import Aer  # Modern provider for Qiskit simulators

# --- 1. AURA CORE CONFIGURATION ---
st.set_page_config(page_title="AURA Standalone Suite", layout="wide", initial_sidebar_state="expanded")

# Custom CSS for the "Aura" Aesthetic
st.markdown("""
    <style>
    .stApp { background: radial-gradient(circle at 50% 50%, #060606 0%, #001a33 100%); }
    section[data-testid="stSidebar"] { background-color: rgba(22, 27, 34, 0.8); border-right: 1px solid #00d4ff; }
    #MainMenu {visibility: hidden;}
    footer {visibility: hidden;}
    .stMetric { background-color: rgba(0, 212, 255, 0.1); padding: 15px; border-radius: 10px; border: 1px solid #00d4ff; }
    </style>
    """, unsafe_allow_html=True)

# --- 2. DATA ENGINE ---
DB_FILE = "Aura_Full_Project.xlsx"

@st.cache_data
def load_aura_data():
    if os.path.exists(DB_FILE):
        return pd.read_excel(DB_FILE)
    else:
        # Create dummy data if file doesn't exist for first run
        df = pd.DataFrame({"Node_ID": [1, 2], "Frequency": [432.0, 528.0], "Output": [1.2, 1.5]})
        df.to_excel(DB_FILE, index=False)
        return df

df = load_aura_data()

# --- 3. SIDEBAR NAVIGATION ---
st.sidebar.title("⚛️ AURA CONTROL")
menu = st.sidebar.selectbox("Select Module", 
    ["Research Dashboard", "AI Training Lab", "Quantum Lab", "System Database"])

# --- MODULE: RESEARCH DASHBOARD ---
if menu == "Research Dashboard":
    st.title("📊 Aura Research Overview")
    col1, col2, col3 = st.columns(3)
    col1.metric("Data Nodes", len(df))
    col2.metric("System Status", "Optimal")
    col3.metric("AI Model", "Active" if os.path.exists('aura_model.pkl') else "None")
    
    st.subheader("Visual Analytics")
    if not df.empty:
        fig = px.area(df, template="plotly_dark", color_discrete_sequence=['#00d4ff'])
        st.plotly_chart(fig, use_container_width=True)

# --- MODULE: AI TRAINING & PREDICTION ---
elif menu == "AI Training Lab":
    st.title("🧠 Aura Neural Intelligence")
    
    tab1, tab2 = st.tabs(["Model Training", "Live Predictor"])
    
    with tab1:
        st.subheader("Train New Model")
        features = st.multiselect("Select Input Features (X)", df.columns, default=df.columns[:-1])
        target = st.selectbox("Select Target to Predict (Y)", df.columns, index=len(df.columns)-1)
        
        if st.button("Initialize Neural Training"):
            X = df[features].fillna(0)
            y = df[target].fillna(0)
            X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
            
            model = RandomForestRegressor(n_estimators=100)
            model.fit(X_train, y_train)
            
            joblib.dump(model, 'aura_model.pkl')
            st.session_state['features'] = features
            st.session_state['target'] = target
            st.success(f"Model trained! Accuracy: {model.score(X_test, y_test):.2%}")

    with tab2:
        st.subheader("🔮 Live Research Predictor")
        if os.path.exists('aura_model.pkl'):
            model = joblib.load('aura_model.pkl')
            # Use columns from training
            input_data = {}
            feature_cols = st.columns(3)
            # Logic to handle features
            for idx, f in enumerate(features):
                with feature_cols[idx % 3]:
                    input_data[f] = st.number_input(f"Enter {f}", value=0.0)
            
            if st.button("Generate Aura Prediction"):
                input_df = pd.DataFrame([input_data])
                prediction = model.predict(input_df)[0]
                st.metric(f"Predicted {target}", f"{prediction:.4f}")
                st.balloons()
                
                # AUTO-SAVE LOGIC
                if st.button("Log to XLSL"):
                    new_entry = input_data.copy()
                    new_entry[target] = prediction
                    updated_df = pd.concat([df, pd.DataFrame([new_entry])], ignore_index=True)
                    updated_df.to_excel(DB_FILE, index=False)
                    st.cache_data.clear()
                    st.success("Entry logged to Aura_Full_Project.xlsx")
        else:
            st.warning("Please train a model in Tab 1 first.")

# --- MODULE: QUANTUM LAB ---
elif menu == "Quantum Lab":
    st.title("🌌 Quantum Simulation Environment")
    qubits = st.slider("Circuit Qubits", 1, 5, 2)
    gate = st.radio("Apply Quantum Gate", ["Superposition (H)", "Bit-Flip (X)"])
    
    if st.button("Run Simulation"):
        qc = QuantumCircuit(qubits, qubits)
        if "H" in gate: qc.h(0)
        else: qc.x(0)
        qc.measure(range(qubits), range(qubits))
        
        backend = Aer.get_backend('qasm_simulator')
        result = backend.run(qc, shots=1024).result()
        counts = result.get_counts()
        
        st.write("### Probability Distribution")
        st.bar_chart(counts)

# --- MODULE: DATABASE ---
elif menu == "System Database":
    st.title("⚙️ Aura System Database")
    st.info("Directly edit the .xlsl research nodes below.")
    edited_df = st.data_editor(df, num_rows="dynamic", use_container_width=True)
    if st.button("Save System Changes"):
        edited_df.to_excel(DB_FILE, index=False)
        st.cache_data.clear()
        st.success("Database synchronized successfully.")
