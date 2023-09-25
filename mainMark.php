<?php
$str_CalcSelfMark = "";

if(!$app['otmetka_all'] == false){
    $str_CalcSelfMark = $str_CalcSelfMark . 'Количественная самооценка ' .  ($app['otmetka_all_count_yes']) . '/(' . ($app['otmetka_all_count_all']) .'-' . ($app['otmetka_all_count_not_need']) . ')'. ' = ' . ($app['otmetka_all']).'%,';
}
/*if(!$app['otmetka_class_1'] == false){
    $str_CalcSelfMark .= ' По 1 классу ' .  ($app['otmetka_class_1_count_yes']) . '/(' . ($app['otmetka_class_1_count_all']) .'-' . ($app['otmetka_class_1_count_not_need']) . ')'. ' = ' . ($app['otmetka_class_1']).'%,';
}
if(!$app['otmetka_class_2'] == false){
    $str_CalcSelfMark .=  ' По 2 классу ' .  ($app['otmetka_class_2_count_yes']) . '/(' . ($app['otmetka_class_2_count_all']) .'-' . ($app['otmetka_class_2_count_not_need']) . ')'. ' = ' . ($app['otmetka_class_2']).'%,';
}
if(!$app['otmetka_class_3'] == false){
    $str_CalcSelfMark .=  ' По 3 классу ' .  ($app['otmetka_class_3_count_yes']) . '/(' . ($app['otmetka_class_3_count_all']) .'-' . ($app['otmetka_class_3_count_not_need']) . ')'. ' = ' . ($app['otmetka_class_3']).'%,';
}*/



$str_CalcSelfMarkAccred = '';



$str_CalcSelfMarkAccred = $str_CalcSelfMarkAccred . 'Количественная оценка ' .  ($app['otmetka_accred_all_count_yes']) . '/(' . ($app['otmetka_accred_all_count_all']) .'-' . ($app['otmetka_accred_all_count_not_need']) . ')'. ' = ' . ($app['otmetka_accred_all']).'%,';

$str_CalcSelfMarkAccred .=  ' Верификация результатов самооценки ' .  ($app['otmetka_verif_count_yes']) . '/(' . ($app['otmetka_verif_count_all']) .'-' . ($app['otmetka_verif_count_not_need']) . ')'. ' = ' . ($app['otmetka_verif']).'%,';

/*$str_CalcSelfMarkAccred .= ' По 1 классу ' .  ($app['otmetka_accred_class_1_count_yes']) . '/(' . ($app['otmetka_accred_class_1_count_all']) .'-' . ($app['otmetka_accred_class_1_count_not_need']) . ')'. ' = ' . ($app['otmetka_accred_class_1']).'%,';

$str_CalcSelfMarkAccred .=  ' По 2 классу ' .  ($app['otmetka_accred_class_2_count_yes']) . '/(' . ($app['otmetka_accred_class_2_count_all']) .'-' . ($app['otmetka_accred_class_2_count_not_need']) . ')'. ' = ' . ($app['otmetka_accred_class_2']).'%,';

$str_CalcSelfMarkAccred .=  ' По 3 классу ' .  ($app['otmetka_accred_class_3_count_yes']) . '/(' . ($app['otmetka_accred_class_3_count_all']) .'-' . ($app['otmetka_accred_class_3_count_not_need']) . ')'. ' = ' . ($app['otmetka_accred_class_3']).'%,';
*/

?>

