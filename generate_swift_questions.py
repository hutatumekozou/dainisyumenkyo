import json

def generate_swift_code():
    filenames = [
        "Resources/frequent_question_1.json",
        "Resources/frequent_question_2.json",
        "Resources/frequent_question_3.json",
        "Resources/frequent_question_4.json",
        "Resources/frequent_question_5.json"
    ]
    
    swift_output = "    // Hardcoded questions for frequent topics to bypass Bundle resource issue\n"
    swift_output += "    private func getFrequentQuestions(for topic: QuizTopic) -> [Question] {\n"
    swift_output += "        switch topic {\n"
    
    topics = [
        "frequentQuestion1",
        "frequentQuestion2",
        "frequentQuestion3",
        "frequentQuestion4",
        "frequentQuestion5"
    ]
    
    for i, filename in enumerate(filenames):
        try:
            with open(filename, 'r', encoding='utf-8') as f:
                questions = json.load(f)
        except FileNotFoundError:
            print(f"File not found: {filename}")
            continue
            
        swift_output += f"        case .{topics[i]}:\n"
        swift_output += "            return [\n"
        
        for q in questions:
            # Escape strings just in case
            q_text = q['question'].replace('"', '\\"').replace('\n', '\\n')
            exp_text = q['explanation'].replace('"', '\\"').replace('\n', '\\n')
            
            # Use a unique String ID
            # q['id'] was int 1..10
            unique_id = f"fq{i+1}_{q['id']}"
            
            choices_str = ", ".join([f'"{c}"' for c in q['choices']])
            
            swift_output += "                Question(\n"
            swift_output += f"                    id: \"{unique_id}\",\n"
            swift_output += f"                    category: \"{topics[i]}\",\n" 
            swift_output += f"                    question: \"{q_text}\",\n"
            swift_output += f"                    choices: [{choices_str}],\n"
            swift_output += f"                    answerIndex: {q['answerIndex']},\n"
            swift_output += f"                    explanation: \"{exp_text}\"\n"
            swift_output += "                ),\n"
        
        swift_output += "            ]\n"
        
    swift_output += "        default:\n"
    swift_output += "            return []\n"
    swift_output += "        }\n"
    swift_output += "    }\n"
    
    print(swift_output)

if __name__ == "__main__":
    generate_swift_code()
