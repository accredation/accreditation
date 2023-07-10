<?php
$str_CalcSelfMark = "";

if(!$app['otmetka_all'] == false){
    $str_CalcSelfMark = $str_CalcSelfMark . 'Количественная оценка самооценки =' . ($app['otmetka_all']).'%,';
}
if(!$app['otmetka_class_1'] == false){
    $str_CalcSelfMark .= ' По 1 классу = ' . ($app['otmetka_class_1']).'%,';
}
if(!$app['otmetka_class_2'] == false){
    $str_CalcSelfMark .=  ' По 2 классу = ' . ($app['otmetka_class_2']).'%,';
}
if(!$app['otmetka_class_3'] == false){
    $str_CalcSelfMark .=  ' По 3 классу = ' . ($app['otmetka_class_3']).'%,';
}


$str_CalcSelfMarkAccred = '';

if(!$app['otmetka_accred_all'] == false){
    $str_CalcSelfMarkAccred = $str_CalcSelfMarkAccred . 'Количественная оценка оценки =' . ($app['otmetka_accred_all']).'%,';
}
if(!$app['otmetka_verif'] == false){
    $str_CalcSelfMarkAccred .=  ' Верификация результатов самооценки = ' . ($app['otmetka_verif']).'%,';
}

if(!$app['otmetka_accred_class_1'] == false){
    $str_CalcSelfMarkAccred .= ' По 1 классу = ' . ($app['otmetka_accred_class_1']).'%,';
}
if(!$app['otmetka_accred_class_2'] == false){
    $str_CalcSelfMarkAccred .=  ' По 2 классу = ' . ($app['otmetka_accred_class_2']).'%,';
}
if(!$app['otmetka_accred_class_3'] == false){
    $str_CalcSelfMarkAccred .=  ' По 3 классу = ' . ($app['otmetka_accred_class_3']).'%,';
} ?>