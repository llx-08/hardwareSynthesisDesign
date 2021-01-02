/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_211(char*, char *);
extern void execute_212(char*, char *);
extern void execute_734(char*, char *);
extern void execute_735(char*, char *);
extern void vlog_simple_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_728(char*, char *);
extern void vlog_const_rhs_process_execute_0_fast_no_reg_no_agg(char*, char*, char*);
extern void execute_730(char*, char *);
extern void execute_731(char*, char *);
extern void execute_732(char*, char *);
extern void execute_733(char*, char *);
extern void execute_353(char*, char *);
extern void execute_354(char*, char *);
extern void execute_355(char*, char *);
extern void execute_364(char*, char *);
extern void execute_365(char*, char *);
extern void execute_366(char*, char *);
extern void execute_367(char*, char *);
extern void execute_368(char*, char *);
extern void execute_370(char*, char *);
extern void execute_371(char*, char *);
extern void execute_375(char*, char *);
extern void execute_376(char*, char *);
extern void execute_377(char*, char *);
extern void execute_378(char*, char *);
extern void execute_379(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_10(char*, char *);
extern void execute_11(char*, char *);
extern void execute_12(char*, char *);
extern void execute_13(char*, char *);
extern void execute_41(char*, char *);
extern void execute_266(char*, char *);
extern void execute_268(char*, char *);
extern void execute_270(char*, char *);
extern void execute_271(char*, char *);
extern void execute_272(char*, char *);
extern void execute_341(char*, char *);
extern void execute_342(char*, char *);
extern void execute_343(char*, char *);
extern void execute_344(char*, char *);
extern void execute_345(char*, char *);
extern void execute_346(char*, char *);
extern void execute_347(char*, char *);
extern void execute_22(char*, char *);
extern void execute_23(char*, char *);
extern void execute_24(char*, char *);
extern void execute_38(char*, char *);
extern void execute_39(char*, char *);
extern void execute_40(char*, char *);
extern void execute_273(char*, char *);
extern void execute_274(char*, char *);
extern void execute_275(char*, char *);
extern void execute_276(char*, char *);
extern void execute_277(char*, char *);
extern void execute_278(char*, char *);
extern void execute_279(char*, char *);
extern void execute_281(char*, char *);
extern void execute_282(char*, char *);
extern void execute_283(char*, char *);
extern void execute_284(char*, char *);
extern void execute_288(char*, char *);
extern void execute_292(char*, char *);
extern void execute_293(char*, char *);
extern void execute_294(char*, char *);
extern void execute_295(char*, char *);
extern void execute_296(char*, char *);
extern void execute_297(char*, char *);
extern void execute_300(char*, char *);
extern void execute_302(char*, char *);
extern void execute_303(char*, char *);
extern void execute_304(char*, char *);
extern void execute_305(char*, char *);
extern void execute_306(char*, char *);
extern void execute_307(char*, char *);
extern void execute_308(char*, char *);
extern void execute_309(char*, char *);
extern void execute_310(char*, char *);
extern void execute_311(char*, char *);
extern void execute_312(char*, char *);
extern void execute_313(char*, char *);
extern void execute_314(char*, char *);
extern void execute_315(char*, char *);
extern void execute_26(char*, char *);
extern void execute_27(char*, char *);
extern void execute_28(char*, char *);
extern void execute_29(char*, char *);
extern void execute_285(char*, char *);
extern void execute_286(char*, char *);
extern void execute_287(char*, char *);
extern void execute_31(char*, char *);
extern void execute_32(char*, char *);
extern void execute_33(char*, char *);
extern void execute_34(char*, char *);
extern void execute_289(char*, char *);
extern void execute_290(char*, char *);
extern void execute_291(char*, char *);
extern void execute_36(char*, char *);
extern void execute_37(char*, char *);
extern void execute_514(char*, char *);
extern void execute_515(char*, char *);
extern void execute_516(char*, char *);
extern void execute_525(char*, char *);
extern void execute_526(char*, char *);
extern void execute_527(char*, char *);
extern void execute_528(char*, char *);
extern void execute_529(char*, char *);
extern void execute_531(char*, char *);
extern void execute_532(char*, char *);
extern void execute_536(char*, char *);
extern void execute_537(char*, char *);
extern void execute_538(char*, char *);
extern void execute_539(char*, char *);
extern void execute_540(char*, char *);
extern void execute_44(char*, char *);
extern void execute_45(char*, char *);
extern void execute_46(char*, char *);
extern void execute_47(char*, char *);
extern void execute_48(char*, char *);
extern void execute_49(char*, char *);
extern void execute_50(char*, char *);
extern void execute_51(char*, char *);
extern void execute_52(char*, char *);
extern void execute_80(char*, char *);
extern void execute_427(char*, char *);
extern void execute_429(char*, char *);
extern void execute_431(char*, char *);
extern void execute_432(char*, char *);
extern void execute_433(char*, char *);
extern void execute_502(char*, char *);
extern void execute_503(char*, char *);
extern void execute_504(char*, char *);
extern void execute_505(char*, char *);
extern void execute_506(char*, char *);
extern void execute_507(char*, char *);
extern void execute_508(char*, char *);
extern void execute_61(char*, char *);
extern void execute_62(char*, char *);
extern void execute_63(char*, char *);
extern void execute_77(char*, char *);
extern void execute_78(char*, char *);
extern void execute_79(char*, char *);
extern void execute_434(char*, char *);
extern void execute_435(char*, char *);
extern void execute_436(char*, char *);
extern void execute_437(char*, char *);
extern void execute_438(char*, char *);
extern void execute_439(char*, char *);
extern void execute_440(char*, char *);
extern void execute_442(char*, char *);
extern void execute_443(char*, char *);
extern void execute_444(char*, char *);
extern void execute_445(char*, char *);
extern void execute_449(char*, char *);
extern void execute_453(char*, char *);
extern void execute_454(char*, char *);
extern void execute_455(char*, char *);
extern void execute_456(char*, char *);
extern void execute_457(char*, char *);
extern void execute_458(char*, char *);
extern void execute_461(char*, char *);
extern void execute_463(char*, char *);
extern void execute_464(char*, char *);
extern void execute_465(char*, char *);
extern void execute_466(char*, char *);
extern void execute_467(char*, char *);
extern void execute_468(char*, char *);
extern void execute_469(char*, char *);
extern void execute_470(char*, char *);
extern void execute_471(char*, char *);
extern void execute_472(char*, char *);
extern void execute_473(char*, char *);
extern void execute_474(char*, char *);
extern void execute_475(char*, char *);
extern void execute_476(char*, char *);
extern void execute_65(char*, char *);
extern void execute_66(char*, char *);
extern void execute_67(char*, char *);
extern void execute_68(char*, char *);
extern void execute_446(char*, char *);
extern void execute_447(char*, char *);
extern void execute_448(char*, char *);
extern void execute_70(char*, char *);
extern void execute_71(char*, char *);
extern void execute_72(char*, char *);
extern void execute_73(char*, char *);
extern void execute_450(char*, char *);
extern void execute_451(char*, char *);
extern void execute_452(char*, char *);
extern void execute_75(char*, char *);
extern void execute_76(char*, char *);
extern void execute_579(char*, char *);
extern void execute_580(char*, char *);
extern void execute_581(char*, char *);
extern void execute_582(char*, char *);
extern void execute_583(char*, char *);
extern void execute_584(char*, char *);
extern void execute_585(char*, char *);
extern void execute_586(char*, char *);
extern void execute_587(char*, char *);
extern void execute_588(char*, char *);
extern void execute_589(char*, char *);
extern void execute_590(char*, char *);
extern void execute_591(char*, char *);
extern void execute_592(char*, char *);
extern void execute_593(char*, char *);
extern void execute_594(char*, char *);
extern void execute_595(char*, char *);
extern void execute_596(char*, char *);
extern void execute_597(char*, char *);
extern void execute_598(char*, char *);
extern void execute_599(char*, char *);
extern void execute_600(char*, char *);
extern void execute_601(char*, char *);
extern void execute_602(char*, char *);
extern void execute_603(char*, char *);
extern void execute_84(char*, char *);
extern void execute_552(char*, char *);
extern void execute_553(char*, char *);
extern void execute_87(char*, char *);
extern void execute_93(char*, char *);
extern void execute_604(char*, char *);
extern void execute_605(char*, char *);
extern void execute_606(char*, char *);
extern void execute_607(char*, char *);
extern void execute_610(char*, char *);
extern void execute_611(char*, char *);
extern void execute_618(char*, char *);
extern void execute_619(char*, char *);
extern void execute_625(char*, char *);
extern void execute_657(char*, char *);
extern void execute_658(char*, char *);
extern void execute_659(char*, char *);
extern void execute_661(char*, char *);
extern void execute_662(char*, char *);
extern void execute_671(char*, char *);
extern void execute_673(char*, char *);
extern void execute_674(char*, char *);
extern void execute_675(char*, char *);
extern void execute_687(char*, char *);
extern void execute_691(char*, char *);
extern void execute_692(char*, char *);
extern void execute_693(char*, char *);
extern void execute_694(char*, char *);
extern void execute_695(char*, char *);
extern void execute_696(char*, char *);
extern void execute_697(char*, char *);
extern void execute_698(char*, char *);
extern void execute_699(char*, char *);
extern void execute_700(char*, char *);
extern void execute_701(char*, char *);
extern void execute_702(char*, char *);
extern void execute_703(char*, char *);
extern void execute_704(char*, char *);
extern void execute_705(char*, char *);
extern void execute_706(char*, char *);
extern void execute_707(char*, char *);
extern void execute_708(char*, char *);
extern void execute_709(char*, char *);
extern void execute_710(char*, char *);
extern void execute_711(char*, char *);
extern void execute_712(char*, char *);
extern void execute_713(char*, char *);
extern void execute_714(char*, char *);
extern void execute_715(char*, char *);
extern void execute_716(char*, char *);
extern void execute_717(char*, char *);
extern void execute_718(char*, char *);
extern void execute_719(char*, char *);
extern void execute_720(char*, char *);
extern void execute_721(char*, char *);
extern void execute_722(char*, char *);
extern void execute_723(char*, char *);
extern void execute_724(char*, char *);
extern void execute_725(char*, char *);
extern void execute_726(char*, char *);
extern void execute_727(char*, char *);
extern void execute_138(char*, char *);
extern void execute_620(char*, char *);
extern void execute_141(char*, char *);
extern void execute_145(char*, char *);
extern void execute_621(char*, char *);
extern void execute_622(char*, char *);
extern void execute_623(char*, char *);
extern void execute_153(char*, char *);
extern void execute_626(char*, char *);
extern void execute_627(char*, char *);
extern void execute_629(char*, char *);
extern void execute_630(char*, char *);
extern void execute_631(char*, char *);
extern void execute_632(char*, char *);
extern void execute_633(char*, char *);
extern void execute_634(char*, char *);
extern void execute_636(char*, char *);
extern void execute_637(char*, char *);
extern void execute_638(char*, char *);
extern void execute_172(char*, char *);
extern void execute_174(char*, char *);
extern void execute_639(char*, char *);
extern void execute_178(char*, char *);
extern void execute_640(char*, char *);
extern void execute_642(char*, char *);
extern void execute_191(char*, char *);
extern void execute_195(char*, char *);
extern void execute_648(char*, char *);
extern void execute_649(char*, char *);
extern void execute_203(char*, char *);
extern void execute_656(char*, char *);
extern void execute_214(char*, char *);
extern void execute_215(char*, char *);
extern void execute_216(char*, char *);
extern void execute_736(char*, char *);
extern void execute_737(char*, char *);
extern void execute_738(char*, char *);
extern void execute_739(char*, char *);
extern void execute_740(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_807(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_817(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_819(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_854(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_877(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_891(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[327] = {(funcp)execute_211, (funcp)execute_212, (funcp)execute_734, (funcp)execute_735, (funcp)vlog_simple_process_execute_0_fast_no_reg_no_agg, (funcp)execute_728, (funcp)vlog_const_rhs_process_execute_0_fast_no_reg_no_agg, (funcp)execute_730, (funcp)execute_731, (funcp)execute_732, (funcp)execute_733, (funcp)execute_353, (funcp)execute_354, (funcp)execute_355, (funcp)execute_364, (funcp)execute_365, (funcp)execute_366, (funcp)execute_367, (funcp)execute_368, (funcp)execute_370, (funcp)execute_371, (funcp)execute_375, (funcp)execute_376, (funcp)execute_377, (funcp)execute_378, (funcp)execute_379, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)execute_12, (funcp)execute_13, (funcp)execute_41, (funcp)execute_266, (funcp)execute_268, (funcp)execute_270, (funcp)execute_271, (funcp)execute_272, (funcp)execute_341, (funcp)execute_342, (funcp)execute_343, (funcp)execute_344, (funcp)execute_345, (funcp)execute_346, (funcp)execute_347, (funcp)execute_22, (funcp)execute_23, (funcp)execute_24, (funcp)execute_38, (funcp)execute_39, (funcp)execute_40, (funcp)execute_273, (funcp)execute_274, (funcp)execute_275, (funcp)execute_276, (funcp)execute_277, (funcp)execute_278, (funcp)execute_279, (funcp)execute_281, (funcp)execute_282, (funcp)execute_283, (funcp)execute_284, (funcp)execute_288, (funcp)execute_292, (funcp)execute_293, (funcp)execute_294, (funcp)execute_295, (funcp)execute_296, (funcp)execute_297, (funcp)execute_300, (funcp)execute_302, (funcp)execute_303, (funcp)execute_304, (funcp)execute_305, (funcp)execute_306, (funcp)execute_307, (funcp)execute_308, (funcp)execute_309, (funcp)execute_310, (funcp)execute_311, (funcp)execute_312, (funcp)execute_313, (funcp)execute_314, (funcp)execute_315, (funcp)execute_26, (funcp)execute_27, (funcp)execute_28, (funcp)execute_29, (funcp)execute_285, (funcp)execute_286, (funcp)execute_287, (funcp)execute_31, (funcp)execute_32, (funcp)execute_33, (funcp)execute_34, (funcp)execute_289, (funcp)execute_290, (funcp)execute_291, (funcp)execute_36, (funcp)execute_37, (funcp)execute_514, (funcp)execute_515, (funcp)execute_516, (funcp)execute_525, (funcp)execute_526, (funcp)execute_527, (funcp)execute_528, (funcp)execute_529, (funcp)execute_531, (funcp)execute_532, (funcp)execute_536, (funcp)execute_537, (funcp)execute_538, (funcp)execute_539, (funcp)execute_540, (funcp)execute_44, (funcp)execute_45, (funcp)execute_46, (funcp)execute_47, (funcp)execute_48, (funcp)execute_49, (funcp)execute_50, (funcp)execute_51, (funcp)execute_52, (funcp)execute_80, (funcp)execute_427, (funcp)execute_429, (funcp)execute_431, (funcp)execute_432, (funcp)execute_433, (funcp)execute_502, (funcp)execute_503, (funcp)execute_504, (funcp)execute_505, (funcp)execute_506, (funcp)execute_507, (funcp)execute_508, (funcp)execute_61, (funcp)execute_62, (funcp)execute_63, (funcp)execute_77, (funcp)execute_78, (funcp)execute_79, (funcp)execute_434, (funcp)execute_435, (funcp)execute_436, (funcp)execute_437, (funcp)execute_438, (funcp)execute_439, (funcp)execute_440, (funcp)execute_442, (funcp)execute_443, (funcp)execute_444, (funcp)execute_445, (funcp)execute_449, (funcp)execute_453, (funcp)execute_454, (funcp)execute_455, (funcp)execute_456, (funcp)execute_457, (funcp)execute_458, (funcp)execute_461, (funcp)execute_463, (funcp)execute_464, (funcp)execute_465, (funcp)execute_466, (funcp)execute_467, (funcp)execute_468, (funcp)execute_469, (funcp)execute_470, (funcp)execute_471, (funcp)execute_472, (funcp)execute_473, (funcp)execute_474, (funcp)execute_475, (funcp)execute_476, (funcp)execute_65, (funcp)execute_66, (funcp)execute_67, (funcp)execute_68, (funcp)execute_446, (funcp)execute_447, (funcp)execute_448, (funcp)execute_70, (funcp)execute_71, (funcp)execute_72, (funcp)execute_73, (funcp)execute_450, (funcp)execute_451, (funcp)execute_452, (funcp)execute_75, (funcp)execute_76, (funcp)execute_579, (funcp)execute_580, (funcp)execute_581, (funcp)execute_582, (funcp)execute_583, (funcp)execute_584, (funcp)execute_585, (funcp)execute_586, (funcp)execute_587, (funcp)execute_588, (funcp)execute_589, (funcp)execute_590, (funcp)execute_591, (funcp)execute_592, (funcp)execute_593, (funcp)execute_594, (funcp)execute_595, (funcp)execute_596, (funcp)execute_597, (funcp)execute_598, (funcp)execute_599, (funcp)execute_600, (funcp)execute_601, (funcp)execute_602, (funcp)execute_603, (funcp)execute_84, (funcp)execute_552, (funcp)execute_553, (funcp)execute_87, (funcp)execute_93, (funcp)execute_604, (funcp)execute_605, (funcp)execute_606, (funcp)execute_607, (funcp)execute_610, (funcp)execute_611, (funcp)execute_618, (funcp)execute_619, (funcp)execute_625, (funcp)execute_657, (funcp)execute_658, (funcp)execute_659, (funcp)execute_661, (funcp)execute_662, (funcp)execute_671, (funcp)execute_673, (funcp)execute_674, (funcp)execute_675, (funcp)execute_687, (funcp)execute_691, (funcp)execute_692, (funcp)execute_693, (funcp)execute_694, (funcp)execute_695, (funcp)execute_696, (funcp)execute_697, (funcp)execute_698, (funcp)execute_699, (funcp)execute_700, (funcp)execute_701, (funcp)execute_702, (funcp)execute_703, (funcp)execute_704, (funcp)execute_705, (funcp)execute_706, (funcp)execute_707, (funcp)execute_708, (funcp)execute_709, (funcp)execute_710, (funcp)execute_711, (funcp)execute_712, (funcp)execute_713, (funcp)execute_714, (funcp)execute_715, (funcp)execute_716, (funcp)execute_717, (funcp)execute_718, (funcp)execute_719, (funcp)execute_720, (funcp)execute_721, (funcp)execute_722, (funcp)execute_723, (funcp)execute_724, (funcp)execute_725, (funcp)execute_726, (funcp)execute_727, (funcp)execute_138, (funcp)execute_620, (funcp)execute_141, (funcp)execute_145, (funcp)execute_621, (funcp)execute_622, (funcp)execute_623, (funcp)execute_153, (funcp)execute_626, (funcp)execute_627, (funcp)execute_629, (funcp)execute_630, (funcp)execute_631, (funcp)execute_632, (funcp)execute_633, (funcp)execute_634, (funcp)execute_636, (funcp)execute_637, (funcp)execute_638, (funcp)execute_172, (funcp)execute_174, (funcp)execute_639, (funcp)execute_178, (funcp)execute_640, (funcp)execute_642, (funcp)execute_191, (funcp)execute_195, (funcp)execute_648, (funcp)execute_649, (funcp)execute_203, (funcp)execute_656, (funcp)execute_214, (funcp)execute_215, (funcp)execute_216, (funcp)execute_736, (funcp)execute_737, (funcp)execute_738, (funcp)execute_739, (funcp)execute_740, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_807, (funcp)transaction_817, (funcp)transaction_819, (funcp)transaction_854, (funcp)transaction_877, (funcp)transaction_891};
const int NumRelocateId= 327;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/testbench_behav/xsim.reloc",  (void **)funcTab, 327);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/testbench_behav/xsim.reloc");
}

	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net

void wrapper_func_0(char *dp)

{

}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/testbench_behav/xsim.reloc");
	wrapper_func_0(dp);

	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstantiate();

extern void implicit_HDL_SCcleanup();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/testbench_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/testbench_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/testbench_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
