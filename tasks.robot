*** Settings ***
Documentation       Template robot main suite.
Library    RPA.OpenAI
Library    RPA.Robocorp.Vault

*** Variables ***
${vault_name}       OpenAI
${vault_key_name}   key
${first_prompt}     What is the biggest mammal? 
${second_prompt}    What do they eat? 
${conversation}     None
${model}            gpt-3.5-turbo    # gpt-3.5-turbo/gpt-4

*** Tasks ***
ChatGPT Template
    ${secrets}   Get Secret    ${vault_name}  
    Authorize To Openai    api_key=${secrets}[${vault_key_name}]

    # First question
    ${response}  @{conversation}   Chat Completion Create
    ...    user_content=${first_prompt}
    ...    conversation=${conversation}
    ...    model=${model}
    Log     ${response}    console=True
    
    # Continue conversation
    ${response}  @{conversation}   Chat Completion Create
    ...    user_content=${second_prompt}
    ...    conversation=${conversation}
    ...    model=${model}
    Log     ${response}    console=True