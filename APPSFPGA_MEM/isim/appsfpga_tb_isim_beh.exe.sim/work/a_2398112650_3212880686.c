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
static const char *ng0 = "/home/ise/ise_proj/dmd-project/APPSFPGA_MEM/src/rtl/write_counter.vhd";
extern char *IEEE_P_3620187407;

char *ieee_p_3620187407_sub_1496620905533649268_3965413181(char *, char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_2255506239096166994_3965413181(char *, char *, char *, char *, int );


static void work_a_2398112650_3212880686_p_0(char *t0)
{
    char t13[16];
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
    int t14;
    unsigned int t15;
    unsigned char t16;
    int64 t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(37, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 5096);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(38, ng0);
    t1 = (t0 + 8425);
    t6 = (t0 + 5240);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 5U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(40, ng0);
    t5 = (t0 + 1672U);
    t6 = *((char **)t5);
    t5 = (t0 + 8280U);
    t7 = (t0 + 8430);
    t9 = (t13 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 0;
    t10 = (t9 + 4U);
    *((int *)t10) = 3;
    t10 = (t9 + 8U);
    *((int *)t10) = 1;
    t14 = (3 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t15;
    t16 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t6, t5, t7, t13);
    if (t16 != 0)
        goto LAB10;

LAB12:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 8280U);
    t5 = (t0 + 8439);
    t7 = (t13 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 0;
    t8 = (t7 + 4U);
    *((int *)t8) = 3;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t14 = (3 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t15;
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t13);
    if (t3 != 0)
        goto LAB13;

LAB14:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 8280U);
    t5 = (t0 + 8448);
    t7 = (t13 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 0;
    t8 = (t7 + 4U);
    *((int *)t8) = 3;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t14 = (3 - 0);
    t15 = (t14 * 1);
    t15 = (t15 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t15;
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t5, t13);
    if (t3 != 0)
        goto LAB15;

LAB16:    xsi_set_current_line(47, ng0);
    t17 = (1 * 1LL);
    t1 = (t0 + 8457);
    t5 = (t0 + 5240);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 5U);
    xsi_driver_first_trans_delta(t5, 0U, 5U, t17);
    t10 = (t0 + 5240);
    xsi_driver_intertial_reject(t10, t17, t17);

LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t12 = xsi_signal_has_event(t1);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(41, ng0);
    t17 = (1 * 1LL);
    t10 = (t0 + 8434);
    t19 = (t0 + 5240);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t10, 5U);
    xsi_driver_first_trans_delta(t19, 0U, 5U, t17);
    t24 = (t0 + 5240);
    xsi_driver_intertial_reject(t24, t17, t17);
    goto LAB11;

LAB13:    xsi_set_current_line(43, ng0);
    t17 = (1 * 1LL);
    t8 = (t0 + 8443);
    t10 = (t0 + 5240);
    t18 = (t10 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 5U);
    xsi_driver_first_trans_delta(t10, 0U, 5U, t17);
    t22 = (t0 + 5240);
    xsi_driver_intertial_reject(t22, t17, t17);
    goto LAB11;

LAB15:    xsi_set_current_line(45, ng0);
    t17 = (1 * 1LL);
    t8 = (t0 + 8452);
    t10 = (t0 + 5240);
    t18 = (t10 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 5U);
    xsi_driver_first_trans_delta(t10, 0U, 5U, t17);
    t22 = (t0 + 5240);
    xsi_driver_intertial_reject(t22, t17, t17);
    goto LAB11;

}

static void work_a_2398112650_3212880686_p_1(char *t0)
{
    char t23[16];
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    int64 t22;
    unsigned int t24;
    unsigned int t25;

LAB0:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t1 = t8;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB10;

LAB11:    t1 = (unsigned char)0;

LAB12:    if (t1 != 0)
        goto LAB8;

LAB9:
LAB3:    t2 = (t0 + 5112);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(56, ng0);
    t2 = (t0 + 8462);
    t10 = (t0 + 5304);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 5U);
    xsi_driver_first_trans_fast(t10);
    goto LAB3;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    xsi_set_current_line(58, ng0);
    t6 = (t0 + 2312U);
    t9 = *((char **)t6);
    t8 = *((unsigned char *)t9);
    t15 = (t8 == (unsigned char)3);
    if (t15 != 0)
        goto LAB13;

LAB15:
LAB14:    goto LAB3;

LAB10:    t2 = (t0 + 992U);
    t7 = xsi_signal_has_event(t2);
    t1 = t7;
    goto LAB12;

LAB13:    xsi_set_current_line(59, ng0);
    t6 = (t0 + 2152U);
    t10 = *((char **)t6);
    t6 = (t0 + 8328U);
    t11 = (t0 + 2472U);
    t12 = *((char **)t11);
    t11 = (t0 + 8344U);
    t16 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t10, t6, t12, t11);
    if (t16 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(62, ng0);
    t22 = (1 * 1LL);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 8328U);
    t6 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t23, t3, t2, 1);
    t9 = (t23 + 12U);
    t24 = *((unsigned int *)t9);
    t25 = (1U * t24);
    t1 = (5U != t25);
    if (t1 == 1)
        goto LAB19;

LAB20:    t10 = (t0 + 5304);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t6, 5U);
    xsi_driver_first_trans_delta(t10, 0U, 5U, t22);
    t17 = (t0 + 5304);
    xsi_driver_intertial_reject(t17, t22, t22);

LAB17:    goto LAB14;

LAB16:    xsi_set_current_line(60, ng0);
    t13 = (t0 + 8467);
    t17 = (t0 + 5304);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t13, 5U);
    xsi_driver_first_trans_fast(t17);
    goto LAB17;

LAB19:    xsi_size_not_matching(5U, t25, 0);
    goto LAB20;

}

static void work_a_2398112650_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(68, ng0);

LAB3:    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 5368);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast(t1);

LAB2:    t8 = (t0 + 5128);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2398112650_3212880686_p_3(char *t0)
{
    char t30[16];
    char t31[16];
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned char t15;
    unsigned char t16;
    unsigned char t17;
    char *t18;
    char *t19;
    unsigned char t20;
    int64 t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    int t32;
    unsigned int t33;
    unsigned int t34;

LAB0:    xsi_set_current_line(73, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t2 = (t0 + 1512U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t1 = t8;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB10;

LAB11:    t1 = (unsigned char)0;

LAB12:    if (t1 != 0)
        goto LAB8;

LAB9:
LAB3:    t2 = (t0 + 5144);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(74, ng0);
    t2 = (t0 + 8472);
    t10 = (t0 + 5432);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 11U);
    xsi_driver_first_trans_fast(t10);
    goto LAB3;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    xsi_set_current_line(76, ng0);
    t6 = (t0 + 2152U);
    t9 = *((char **)t6);
    t6 = (t0 + 8328U);
    t10 = (t0 + 2472U);
    t11 = *((char **)t10);
    t10 = (t0 + 8344U);
    t15 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t9, t6, t11, t10);
    if (t15 == 1)
        goto LAB16;

LAB17:    t8 = (unsigned char)0;

LAB18:    if (t8 != 0)
        goto LAB13;

LAB15:
LAB14:    goto LAB3;

LAB10:    t2 = (t0 + 992U);
    t7 = xsi_signal_has_event(t2);
    t1 = t7;
    goto LAB12;

LAB13:    xsi_set_current_line(77, ng0);
    t12 = (t0 + 2632U);
    t14 = *((char **)t12);
    t12 = (t0 + 8360U);
    t18 = (t0 + 1832U);
    t19 = *((char **)t18);
    t18 = (t0 + 8296U);
    t20 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t14, t12, t19, t18);
    if (t20 != 0)
        goto LAB19;

LAB21:    xsi_set_current_line(80, ng0);
    t21 = (1 * 1LL);
    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t2 = (t0 + 8360U);
    t6 = (t0 + 8494);
    t10 = (t31 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 0;
    t11 = (t10 + 4U);
    *((int *)t11) = 10;
    t11 = (t10 + 8U);
    *((int *)t11) = 1;
    t32 = (10 - 0);
    t33 = (t32 * 1);
    t33 = (t33 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t33;
    t11 = ieee_p_3620187407_sub_1496620905533649268_3965413181(IEEE_P_3620187407, t30, t3, t2, t6, t31);
    t12 = (t30 + 12U);
    t33 = *((unsigned int *)t12);
    t34 = (1U * t33);
    t1 = (11U != t34);
    if (t1 == 1)
        goto LAB22;

LAB23:    t13 = (t0 + 5432);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    t19 = (t18 + 56U);
    t22 = *((char **)t19);
    memcpy(t22, t11, 11U);
    xsi_driver_first_trans_delta(t13, 0U, 11U, t21);
    t23 = (t0 + 5432);
    xsi_driver_intertial_reject(t23, t21, t21);

LAB20:    goto LAB14;

LAB16:    t12 = (t0 + 1352U);
    t13 = *((char **)t12);
    t16 = *((unsigned char *)t13);
    t17 = (t16 == (unsigned char)3);
    t8 = t17;
    goto LAB18;

LAB19:    xsi_set_current_line(78, ng0);
    t21 = (1 * 1LL);
    t22 = (t0 + 8483);
    t24 = (t0 + 5432);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    t27 = (t26 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t22, 11U);
    xsi_driver_first_trans_delta(t24, 0U, 11U, t21);
    t29 = (t0 + 5432);
    xsi_driver_intertial_reject(t29, t21, t21);
    goto LAB20;

LAB22:    xsi_size_not_matching(11U, t34, 0);
    goto LAB23;

}

static void work_a_2398112650_3212880686_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(86, ng0);

LAB3:    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 5496);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 11U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 5160);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2398112650_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2398112650_3212880686_p_0,(void *)work_a_2398112650_3212880686_p_1,(void *)work_a_2398112650_3212880686_p_2,(void *)work_a_2398112650_3212880686_p_3,(void *)work_a_2398112650_3212880686_p_4};
	xsi_register_didat("work_a_2398112650_3212880686", "isim/appsfpga_tb_isim_beh.exe.sim/work/a_2398112650_3212880686.didat");
	xsi_register_executes(pe);
}
