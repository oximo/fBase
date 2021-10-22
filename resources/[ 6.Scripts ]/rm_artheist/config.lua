Config = {}
Config['ArtHeist'] = {
    ['nextRob'] = 1800, -- seconds for next heist
    ['startHeist'] ={ -- heist start coords
        pos = vector3(244.346, 374.012, 105.738),
        peds = {
            {pos = vector3(244.346, 374.012, 105.738), heading = 156.39, ped = 's_m_m_highsec_01'},
            {pos = vector3(243.487, 372.176, 105.738), heading = 265.63, ped = 's_m_m_highsec_02'},
            {pos = vector3(245.074, 372.730, 105.738), heading = 73.3, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['sellPainting'] ={ -- sell painting coords
        pos = vector3(288.558, -2981.1, 5.90696),
        peds = {
            {pos = vector3(288.558, -2981.1, 5.90696), heading = 135.88, ped = 's_m_m_highsec_01'},
            {pos = vector3(287.190, -2980.9, 5.72252), heading = 218.0, ped = 's_m_m_highsec_02'},
            {pos = vector3(287.731, -2982.6, 5.82852), heading = 336.08, ped = 's_m_m_fiboffice_02'}
        }
    },
    ['painting'] = {
        {
            rewardItem = 'paintinge', -- u need add item to database
            paintingPrice = '5000', -- price of the reward item for sell
            scenePos = vector3(23.75, 157.82, 93.0), -- animation coords
            sceneRot = vector3(0.0, 0.0, 339.23), -- animation rotation
            object = 'ch_prop_vault_painting_01e', -- object (https://mwojtasik.dev/tools/gtav/objects/search?name=ch_prop_vault_painting_01)
            objectPos = vector3(23.90, 158.18, 94.0), -- object spawn coords
            objHeading = 339.23 -- object spawn heading
        },
        {
            rewardItem = 'paintingi',
            paintingPrice = '5000', 
            scenePos = vector3(34.45, 148.0, 93.0),  ----- faut finir
            sceneRot = vector3(0.0, 0.0, 251.18),
            object = 'ch_prop_vault_painting_01i', 
            objectPos = vector3(34.90, 148.0, 94.0), 
            objHeading = 251.18
        },
        {
            rewardItem = 'paintingh',
            paintingPrice = '5000', 
            scenePos = vector3(28.00, 139.10, 94.0), 
            sceneRot = vector3(0.0, 0.0, 71.62),
            object = 'ch_prop_vault_painting_01h', 
            objectPos = vector3(27.55, 139.10, 94.0), 
            objHeading = 71.62
        },
        {
            rewardItem = 'paintingj',
            paintingPrice = '5000', 
            scenePos = vector3(29.45, 134.49, 92.90), 
            sceneRot = vector3(0.0, 0.0, 248.12),
            object = 'ch_prop_vault_painting_01j', 
            objectPos = vector3(29.90, 134.35, 94.0), 
            objHeading = 248.12
        },
        {
            rewardItem = 'paintingf',
            paintingPrice = '5000', 
            scenePos = vector3(41.40, 133.99, 93.0), 
            sceneRot = vector3(0.0, 0.0, 248.85),
            object = 'ch_prop_vault_painting_01f', 
            objectPos = vector3(42.05, 134.10, 94.0), 
            objHeading = 248.85
        },
        {
            rewardItem = 'paintingg',
            paintingPrice = '5000', 
            scenePos = vector3(43.90, 140.39, 94.0), 
            sceneRot = vector3(0.0, 0.0, 252.41),
            object = 'ch_prop_vault_painting_01g', 
            objectPos = vector3(44.35, 140.39, 94.0), 
            objHeading = 252.41
        },
    },
    ['objects'] = { -- dont change (required)
        'hei_p_m_bag_var22_arm_s',
        'w_me_switchblade'
    },
    ['animations'] = { -- dont change (required)
        {"top_left_enter", "top_left_enter_ch_prop_ch_sec_cabinet_02a", "top_left_enter_ch_prop_vault_painting_01a", "top_left_enter_hei_p_m_bag_var22_arm_s", "top_left_enter_w_me_switchblade"},
        {"cutting_top_left_idle", "cutting_top_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_idle_ch_prop_vault_painting_01a", "cutting_top_left_idle_hei_p_m_bag_var22_arm_s", "cutting_top_left_idle_w_me_switchblade"},
        {"cutting_top_left_to_right", "cutting_top_left_to_right_ch_prop_ch_sec_cabinet_02a", "cutting_top_left_to_right_ch_prop_vault_painting_01a", "cutting_top_left_to_right_hei_p_m_bag_var22_arm_s", "cutting_top_left_to_right_w_me_switchblade"},
        {"cutting_top_right_idle", "_cutting_top_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_top_right_idle_ch_prop_vault_painting_01a", "cutting_top_right_idle_hei_p_m_bag_var22_arm_s", "cutting_top_right_idle_w_me_switchblade"},
        {"cutting_right_top_to_bottom", "cutting_right_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_right_top_to_bottom_ch_prop_vault_painting_01a", "cutting_right_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_right_top_to_bottom_w_me_switchblade"},
        {"cutting_bottom_right_idle", "cutting_bottom_right_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_idle_ch_prop_vault_painting_01a", "cutting_bottom_right_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_idle_w_me_switchblade"},
        {"cutting_bottom_right_to_left", "cutting_bottom_right_to_left_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_right_to_left_ch_prop_vault_painting_01a", "cutting_bottom_right_to_left_hei_p_m_bag_var22_arm_s", "cutting_bottom_right_to_left_w_me_switchblade"},
        {"cutting_bottom_left_idle", "cutting_bottom_left_idle_ch_prop_ch_sec_cabinet_02a", "cutting_bottom_left_idle_ch_prop_vault_painting_01a", "cutting_bottom_left_idle_hei_p_m_bag_var22_arm_s", "cutting_bottom_left_idle_w_me_switchblade"},
        {"cutting_left_top_to_bottom", "cutting_left_top_to_bottom_ch_prop_ch_sec_cabinet_02a", "cutting_left_top_to_bottom_ch_prop_vault_painting_01a", "cutting_left_top_to_bottom_hei_p_m_bag_var22_arm_s", "cutting_left_top_to_bottom_w_me_switchblade"},
        {"with_painting_exit", "with_painting_exit_ch_prop_ch_sec_cabinet_02a", "with_painting_exit_ch_prop_vault_painting_01a", "with_painting_exit_hei_p_m_bag_var22_arm_s", "with_painting_exit_w_me_switchblade"},
    },
}

Strings = {
    ['steal_blip'] = 'Galerie d\'Art',
    ['sell_blip'] = 'Clients de peinture',
    ['start_stealing'] = 'Appuyer sur ~INPUT_CONTEXT~ pour voler',
    ['cute_right'] = 'Appuyer sur ~INPUT_CONTEXT~ pour couper à droite',
    ['cute_left'] = 'Appuyer sur ~INPUT_CONTEXT~ pour couper à gauche',
    ['cute_down'] = 'Appuyer sur ~INPUT_CONTEXT~ pour couper',
    ['go_steal'] = 'Allez à la Galerie d\'Art et volez de la peinture.',
    ['go_sell'] = 'Allez sur blip et vendez de la peinture.',
    ['already_cuting'] = 'Tu voles déjà.',
    ['already_heist'] = 'Vous avez déjà commencé le casse. Attendez que ce soit fini.',
    ['start_heist'] = 'Appuyer sur ~INPUT_CONTEXT~ pour lancer le cambriolage de tableau',
    ['sell_painting'] = 'Appuyer sur ~INPUT_CONTEXT~ pour vendre de la peinture.',
    ['wait_nextrob'] = 'Tu dois attendre pour faire un second braquage',
    ['minute'] = 'Minute',
    ['police_alert'] = 'Alerte au vol d\'art ! Vérifiez votre GPS.',
}