/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xfbc00daa */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/home/ise/ise_proj/dmd-project/APPSFPGA_MEM/src/rtl/counter_4096.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

char *ieee_p_3620187407_sub_1496620905533649268_3965413181(char *, char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_1496620905533721142_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_1114591794_3212880686_p_0(char *t0)
{
    char t15[16];
    char t29[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned char t13;
    unsigned char t14;
    unsigned int t16;
    int t17;
    int t18;
    int t19;
    char *t20;
    int t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    unsigned int t30;

LAB0:    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 3672);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(53, ng0);
    t1 = (t0 + 6050);
    t6 = (t0 + 3768);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 12U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 1352U);
    t6 = *((char **)t2);
    t13 = *((unsigned char *)t6);
    t2 = (t0 + 1512U);
    t7 = *((char **)t2);
    t14 = *((unsigned char *)t7);
    t8 = ((IEEE_P_2592010699) + 4000);
    t2 = xsi_base_array_concat(t2, t15, t8, (char)99, t13, (char)99, t14, (char)101);
    t9 = (t0 + 2128U);
    t10 = *((char **)t9);
    t9 = (t10 + 0);
    t16 = (1U + 1U);
    memcpy(t9, t2, t16);
    xsi_set_current_line(56, ng0);
    t1 = (t0 + 2128U);
    t2 = *((char **)t1);
    t1 = (t0 + 6062);
    t17 = xsi_mem_cmp(t1, t2, 2U);
    if (t17 == 1)
        goto LAB11;

LAB16:    t6 = (t0 + 6064);
    t18 = xsi_mem_cmp(t6, t2, 2U);
    if (t18 == 1)
        goto LAB12;

LAB17:    t8 = (t0 + 6066);
    t19 = xsi_mem_cmp(t8, t2, 2U);
    if (t19 == 1)
        goto LAB13;

LAB18:    t10 = (t0 + 6068);
    t21 = xsi_mem_cmp(t10, t2, 2U);
    if (t21 == 1)
        goto LAB14;

LAB19:
LAB15:    xsi_set_current_line(61, ng0);
    t1 = (t0 + 6106);
    t5 = (t0 + 3768);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 12U);
    xsi_driver_first_trans_fast(t5);

LAB10:    goto LAB3;

LAB7:    t2 = (t0 + 1032U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

LAB11:    xsi_set_current_line(57, ng0);
    t22 = (t0 + 6070);
    t24 = (t0 + 3768);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t22, 12U);
    xsi_driver_first_trans_fast(t24);
    goto LAB10;

LAB12:    xsi_set_current_line(58, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 3768);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 12U);
    xsi_driver_first_trans_fast(t1);
    goto LAB10;

LAB13:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 5992U);
    t5 = (t0 + 6082);
    t7 = (t29 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 0;
    t8 = (t7 + 4U);
    *((int *)t8) = 11;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t17 = (11 - 0);
    t16 = (t17 * 1);
    t16 = (t16 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t16;
    t8 = ieee_p_3620187407_sub_1496620905533721142_3965413181(IEEE_P_3620187407, t15, t2, t1, t5, t29);
    t9 = (t15 + 12U);
    t16 = *((unsigned int *)t9);
    t30 = (1U * t16);
    t3 = (12U != t30);
    if (t3 == 1)
        goto LAB21;

LAB22:    t10 = (t0 + 3768);
    t20 = (t10 + 56U);
    t22 = *((char **)t20);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t8, 12U);
    xsi_driver_first_trans_fast(t10);
    goto LAB10;

LAB14:    xsi_set_current_line(60, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 5992U);
    t5 = (t0 + 6094);
    t7 = (t29 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 0;
    t8 = (t7 + 4U);
    *((int *)t8) = 11;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t17 = (11 - 0);
    t16 = (t17 * 1);
    t16 = (t16 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t16;
    t8 = ieee_p_3620187407_sub_1496620905533649268_3965413181(IEEE_P_3620187407, t15, t2, t1, t5, t29);
    t9 = (t15 + 12U);
    t16 = *((unsigned int *)t9);
    t30 = (1U * t16);
    t3 = (12U != t30);
    if (t3 == 1)
        goto LAB23;

LAB24:    t10 = (t0 + 3768);
    t20 = (t10 + 56U);
    t22 = *((char **)t20);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t8, 12U);
    xsi_driver_first_trans_fast(t10);
    goto LAB10;

LAB20:;
LAB21:    xsi_size_not_matching(12U, t30, 0);
    goto LAB22;

LAB23:    xsi_size_not_matching(12U, t30, 0);
    goto LAB24;

}

static void work_a_1114591794_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(67, ng0);

LAB3:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 3832);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 12U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3688);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1114591794_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1114591794_3212880686_p_0,(void *)work_a_1114591794_3212880686_p_1};
	xsi_register_didat("work_a_1114591794_3212880686", "isim/appsfpga_tb_isim_beh.exe.sim/work/a_1114591794_3212880686.didat");
	xsi_register_executes(pe);
}
