-- Executado na inicialização da simulação
if (sim_call_type == sim.syscb_init) then 
    -- Pega os identificadores (handles) das juntas de direção e do motor
    steer_handle = sim.getObjectHandle('steer_joint')
    motor_handle = sim.getObjectHandle('motor_joint')

    -- Pega os identificadores dos freios (um para cada roda)
    fl_brake_handle = sim.getObjectHandle('fl_brake_joint')
    fr_brake_handle = sim.getObjectHandle('fr_brake_joint')
    bl_brake_handle = sim.getObjectHandle('bl_brake_joint')
    br_brake_handle = sim.getObjectHandle('brake_joint')
    
    -- Parâmetros físicos do veículo:
    --wheel radius: 0.09 m
    --wheel base: 0.6 m
    --wheel track: 0.35 m
    --maximum steering rate: 70 deg/sec

    -- Ângulo máximo de direção (em radianos) ~30°
    max_steer_angle = 0.5235987
    
    -- Torque máximo do motor
    motor_torque = 60

    -- Incrementos de velocidade e direção
    dVel = 1
    dSteer = 0.1

    -- Ângulo inicial de direção
    steer_angle = 0
    
    -- Velocidade inicial do motor
    motor_velocity = dVel * 10
    
    -- Força de frenagem inicial
    brake_force = 0
end 

-- Executado no encerramento da simulação (não faz nada neste caso)
if (sim_call_type == sim.syscb_cleanup) then 
end 

-- Executado a cada passo de simulação (loop principal)
if (sim_call_type == sim.syscb_actuation) then 
    -- Lê a posição atual da junta de direção
    steer_pos = sim.getJointPosition(steer_handle)

    -- Lê a velocidade angular da roda traseira esquerda
    bl_wheel_velocity = sim.getObjectFloatParameter(bl_brake_handle, 2012)

    -- Lê a velocidade angular da roda traseira direita
    br_wheel_velocity = sim.getObjectFloatParameter(br_brake_handle, 2012)

    -- Calcula a velocidade média das rodas traseiras
    rear_wheel_velocity = (bl_wheel_velocity + br_wheel_velocity) / 2

    -- Converte para velocidade linear (multiplicando pelo raio da roda)
    linear_velocity = rear_wheel_velocity * 0.09 
    
    -- Lê mensagens do teclado (certifique-se de que a janela do CoppeliaSim está com foco)
    message, auxiliaryData = sim.getSimulatorMessage()
    while message ~= -1 do
        if (message == sim.message_keypress) then
            -- Mostra a tecla pressionada na barra de status
            Msg = "Tecla: "
            Msg = Msg .. auxiliaryData[1]
            sim.addStatusbarMessage(Msg)

            -- Verifica qual tecla foi pressionada (códigos do CoppeliaSim):
            if (auxiliaryData[1] == 2007) then
                -- Seta para cima: acelera
                if (motor_velocity < dVel * 9.99) then
                    motor_velocity = motor_velocity + dVel
                end
            end
            if (auxiliaryData[1] == 2008) then
                -- Seta para baixo: ré / desacelera
                if (motor_velocity > -dVel * 1.99) then
                    motor_velocity = motor_velocity - dVel
                else
                    -- Pode ativar o freio aqui, se desejado
                end
            end
            if (auxiliaryData[1] == 2009) then
                -- Seta para esquerda: vira para esquerda
                if (steer_angle < dSteer * 4.99) then
                    steer_angle = steer_angle + dSteer
                end
            end
            if (auxiliaryData[1] == 2010) then
                -- Seta para direita: vira para direita
                if (steer_angle > -dSteer * 4.99) then
                    steer_angle = steer_angle - dSteer
                end
            end
            if (auxiliaryData[1] == 115) then
                -- Tecla "S": para o motor
                motor_velocity = 0.0
            end
        end
        -- Lê a próxima mensagem do teclado
        message, auxiliaryData = sim.getSimulatorMessage()
    end
    
    -- Se a velocidade estiver quase zero, aplica o freio
    if (math.abs(motor_velocity) < dVel * 0.1) then
        brake_force = 100
    else
        brake_force = 0
    end

    -- Limita o ângulo de direção ao máximo permitido
    if (steer_angle > max_steer_angle) then
        steer_angle = max_steer_angle
    end
    if (steer_angle < -max_steer_angle) then
        steer_angle = -max_steer_angle
    end

    -- Aplica a posição de direção no atuador
    sim.setJointTargetPosition(steer_handle, steer_angle)
    
    -- Aplica o torque do motor ou aciona o freio (não ambos simultaneamente)
    if (brake_force > 0) then
        sim.setJointForce(motor_handle, 0)
    else
        sim.setJointForce(motor_handle, motor_torque)
        sim.setJointTargetVelocity(motor_handle, motor_velocity)
    end

    -- Aplica a força de freio em todas as rodas
    sim.setJointForce(fr_brake_handle, brake_force)
    sim.setJointForce(fl_brake_handle, brake_force)
    sim.setJointForce(bl_brake_handle, brake_force)
    sim.setJointForce(br_brake_handle, brake_force)
end 

-- Este código implementa um sistema de controle por teclado para o robô Manta no CoppeliaSim.
-- A simulação lê continuamente as teclas pressionadas para controlar a velocidade (acelerar/reduzir),
-- a direção (virar para os lados) e a frenagem. As entradas são convertidas em comandos de
-- velocidade do motor, ângulo da direção e aplicação de força nos freios. 
-- O sistema também limita os valores máximos de direção e aplica frenagem automática quando parado.