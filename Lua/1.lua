-- Função chamada uma vez no início da simulação
function sysCall_init() 
    -- Obtém o próprio robô (objeto que contém este script)
    local robot = sim.getObject('.')

    -- Cria uma coleção de objetos para representar os obstáculos
    local obstacles = sim.createCollection(0)
    
    -- Adiciona todos os objetos da cena à coleção
    sim.addItemToCollection(obstacles, sim.handle_all, -1, 0)
    
    -- Remove o robô e seus componentes da coleção para evitar autointerferência
    sim.addItemToCollection(obstacles, sim.handle_tree, robot, 1)
    
    -- Vetor para armazenar os 16 sensores ultrassônicos
    usensors = {}
    for i = 1, 16, 1 do
        -- Obtém cada sensor com base no índice
        usensors[i] = sim.getObject("./ultrasonicSensor", { index = i - 1 })

        -- Configura o sensor para detectar apenas objetos da coleção "obstacles"
        sim.setObjectInt32Param(usensors[i], sim.proxintparam_entity_to_detect, obstacles)
    end

    -- Referencia os motores das rodas
    motorLeft = sim.getObject("./leftMotor")
    motorRight = sim.getObject("./rightMotor")

    -- Define as distâncias usadas para calcular a intensidade da detecção
    noDetectionDist = 0.5         -- Distância máxima sem detecção
    maxDetectionDist = 0.2        -- Distância mínima (mais próxima)

    -- Vetor que armazena os valores de detecção normalizados (0 a 1)
    detect = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}

    -- Pesos para os sensores afetarem a velocidade da roda esquerda
    braitenbergL = {-0.2, -0.4, -0.6, -0.8, -1, -1.2, -1.4, -1.6, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}

    -- Pesos para os sensores afetarem a velocidade da roda direita
    braitenbergR = {-1.6, -1.4, -1.2, -1, -0.8, -0.6, -0.4, -0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0}

    -- Velocidade base das rodas
    v0 = 2
end

-- Função chamada ao final da simulação (não utilizada aqui)
function sysCall_cleanup() 
end 

-- Função chamada a cada passo da simulação (loop principal de controle)
function sysCall_actuation() 
    -- Loop pelos 16 sensores para calcular a intensidade de detecção
    for i = 1, 16, 1 do
        res, dist = sim.readProximitySensor(usensors[i])
        if (res > 0) and (dist < noDetectionDist) then
            -- Garante que a distância não seja menor que o mínimo
            if (dist < maxDetectionDist) then
                dist = maxDetectionDist
            end

            -- Normaliza o valor de detecção entre 0 e 1
            detect[i] = 1 - ((dist - maxDetectionDist) / (noDetectionDist - maxDetectionDist))
        else
            -- Sem detecção
            detect[i] = 0
        end
    end
    
    -- Inicializa as velocidades com o valor base
    vLeft = v0
    vRight = v0

    -- Ajusta as velocidades com base nas leituras dos sensores
    for i = 1, 16, 1 do
        vLeft = vLeft + braitenbergL[i] * detect[i]
        vRight = vRight + braitenbergR[i] * detect[i]
    end

    -- Aplica as velocidades calculadas nos motores
    sim.setJointTargetVelocity(motorLeft, vLeft)
    sim.setJointTargetVelocity(motorRight, vRight)
end

-- Este robô se move para frente (v0=2) e evita obstáculos ajustando a velocidade das rodas 
-- com base nas leituras dos sensores ultrassônicos, utilizando pesos do modelo Braitenberg. 
-- Isso simula um comportamento "instintivo" de desvio automático de obstáculos.