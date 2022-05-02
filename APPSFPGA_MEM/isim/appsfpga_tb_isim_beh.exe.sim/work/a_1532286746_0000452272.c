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
static const char *ng0 = "/home/ise/ise_proj/dmd-project/APPSFPGA_MEM/ipcore_dir/mig_top/user_design/rtl/ddr2_infrastructure.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_3488546069778340532_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


static void work_a_1532286746_0000452272_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(118, ng0);
    t1 = (1 != 0);
    if (t1 != 0)
        goto LAB3;

LAB4:
LAB5:    t10 = (t0 + 1832U);
    t11 = *((char **)t10);
    t12 = *((unsigned char *)t11);
    t10 = (t0 + 7920);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = t12;
    xsi_driver_first_trans_fast(t10);

LAB2:    t17 = (t0 + 7696);
    *((int *)t17) = 1;

LAB1:    return;
LAB3:    t2 = (t0 + 1832U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t4);
    t2 = (t0 + 7920);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t5;
    xsi_driver_first_trans_fast(t2);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_1532286746_0000452272_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(133, ng0);

LAB3:    t1 = (t0 + 3752U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 1672U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t5);
    t7 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t3, t6);
    t1 = (t0 + 1992U);
    t8 = *((char **)t1);
    t9 = *((unsigned char *)t8);
    t10 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t9);
    t11 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t7, t10);
    t1 = (t0 + 7984);
    t12 = (t1 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t11;
    xsi_driver_first_trans_fast(t1);

LAB2:    t16 = (t0 + 7712);
    *((int *)t16) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1532286746_0000452272_p_2(char *t0)
{
    char t16[16];
    char t17[16];
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
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;

LAB0:    xsi_set_current_line(137, ng0);
    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7728);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(138, ng0);
    t1 = xsi_get_transient_memory(25U);
    memset(t1, 0, 25U);
    t5 = t1;
    memset(t5, (unsigned char)3, 25U);
    t6 = (t0 + 8048);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 25U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(141, ng0);
    t2 = (t0 + 2792U);
    t5 = *((char **)t2);
    t2 = (t0 + 4168U);
    t6 = *((char **)t2);
    t11 = *((int *)t6);
    t12 = (t11 - 2);
    t13 = (24 - t12);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t2 = (t5 + t15);
    t8 = ((IEEE_P_2592010699) + 4000);
    t9 = (t17 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 23;
    t10 = (t9 + 4U);
    *((int *)t10) = 0;
    t10 = (t9 + 8U);
    *((int *)t10) = -1;
    t18 = (0 - 23);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t19;
    t7 = xsi_base_array_concat(t7, t16, t8, (char)97, t2, t17, (char)99, (unsigned char)2, (char)101);
    t19 = (24U + 1U);
    t4 = (25U != t19);
    if (t4 == 1)
        goto LAB7;

LAB8:    t10 = (t0 + 8048);
    t20 = (t10 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t7, 25U);
    xsi_driver_first_trans_fast(t10);
    goto LAB3;

LAB7:    xsi_size_not_matching(25U, t19, 0);
    goto LAB8;

}

static void work_a_1532286746_0000452272_p_3(char *t0)
{
    char t17[16];
    char t18[16];
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
    int t11;
    int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(147, ng0);
    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1472U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7744);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(148, ng0);
    t1 = xsi_get_transient_memory(12U);
    memset(t1, 0, 12U);
    t5 = t1;
    memset(t5, (unsigned char)3, 12U);
    t6 = (t0 + 8112);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 12U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(151, ng0);
    t2 = (t0 + 3272U);
    t5 = *((char **)t2);
    t2 = (t0 + 4168U);
    t6 = *((char **)t2);
    t11 = *((int *)t6);
    t12 = (t11 / 2);
    t13 = (t12 - 2);
    t14 = (11 - t13);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t2 = (t5 + t16);
    t8 = ((IEEE_P_2592010699) + 4000);
    t9 = (t18 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 10;
    t10 = (t9 + 4U);
    *((int *)t10) = 0;
    t10 = (t9 + 8U);
    *((int *)t10) = -1;
    t19 = (0 - 10);
    t20 = (t19 * -1);
    t20 = (t20 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t20;
    t7 = xsi_base_array_concat(t7, t17, t8, (char)97, t2, t18, (char)99, (unsigned char)2, (char)101);
    t20 = (11U + 1U);
    t4 = (12U != t20);
    if (t4 == 1)
        goto LAB7;

LAB8:    t10 = (t0 + 8112);
    t21 = (t10 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t7, 12U);
    xsi_driver_first_trans_fast(t10);
    goto LAB3;

LAB7:    xsi_size_not_matching(12U, t20, 0);
    goto LAB8;

}

static void work_a_1532286746_0000452272_p_4(char *t0)
{
    char t16[16];
    char t17[16];
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
    int t11;
    int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;

LAB0:    xsi_set_current_line(157, ng0);
    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1152U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7760);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(158, ng0);
    t1 = xsi_get_transient_memory(25U);
    memset(t1, 0, 25U);
    t5 = t1;
    memset(t5, (unsigned char)3, 25U);
    t6 = (t0 + 8176);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 25U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(160, ng0);
    t2 = (t0 + 3112U);
    t5 = *((char **)t2);
    t2 = (t0 + 4168U);
    t6 = *((char **)t2);
    t11 = *((int *)t6);
    t12 = (t11 - 2);
    t13 = (24 - t12);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t2 = (t5 + t15);
    t8 = ((IEEE_P_2592010699) + 4000);
    t9 = (t17 + 0U);
    t10 = (t9 + 0U);
    *((int *)t10) = 23;
    t10 = (t9 + 4U);
    *((int *)t10) = 0;
    t10 = (t9 + 8U);
    *((int *)t10) = -1;
    t18 = (0 - 23);
    t19 = (t18 * -1);
    t19 = (t19 + 1);
    t10 = (t9 + 12U);
    *((unsigned int *)t10) = t19;
    t7 = xsi_base_array_concat(t7, t16, t8, (char)97, t2, t17, (char)99, (unsigned char)2, (char)101);
    t19 = (24U + 1U);
    t4 = (25U != t19);
    if (t4 == 1)
        goto LAB7;

LAB8:    t10 = (t0 + 8176);
    t20 = (t10 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t7, 25U);
    xsi_driver_first_trans_fast(t10);
    goto LAB3;

LAB7:    xsi_size_not_matching(25U, t19, 0);
    goto LAB8;

}

static void work_a_1532286746_0000452272_p_5(char *t0)
{
    char t17[16];
    char t18[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(167, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1312U);
    t3 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 7776);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(168, ng0);
    t1 = xsi_get_transient_memory(25U);
    memset(t1, 0, 25U);
    t6 = t1;
    memset(t6, (unsigned char)3, 25U);
    t7 = (t0 + 8240);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 25U);
    xsi_driver_first_trans_fast(t7);
    goto LAB3;

LAB5:    xsi_set_current_line(170, ng0);
    t2 = (t0 + 2952U);
    t6 = *((char **)t2);
    t2 = (t0 + 4168U);
    t7 = *((char **)t2);
    t12 = *((int *)t7);
    t13 = (t12 - 2);
    t14 = (24 - t13);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t2 = (t6 + t16);
    t9 = ((IEEE_P_2592010699) + 4000);
    t10 = (t18 + 0U);
    t11 = (t10 + 0U);
    *((int *)t11) = 23;
    t11 = (t10 + 4U);
    *((int *)t11) = 0;
    t11 = (t10 + 8U);
    *((int *)t11) = -1;
    t19 = (0 - 23);
    t20 = (t19 * -1);
    t20 = (t20 + 1);
    t11 = (t10 + 12U);
    *((unsigned int *)t11) = t20;
    t8 = xsi_base_array_concat(t8, t17, t9, (char)97, t2, t18, (char)99, (unsigned char)2, (char)101);
    t20 = (24U + 1U);
    t4 = (25U != t20);
    if (t4 == 1)
        goto LAB7;

LAB8:    t11 = (t0 + 8240);
    t21 = (t11 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t8, 25U);
    xsi_driver_first_trans_fast(t11);
    goto LAB3;

LAB7:    xsi_size_not_matching(25U, t20, 0);
    goto LAB8;

}

static void work_a_1532286746_0000452272_p_6(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(174, ng0);

LAB3:    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 4168U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 1);
    t6 = (t5 - 24);
    t7 = (t6 * -1);
    t8 = (1U * t7);
    t9 = (0 + t8);
    t1 = (t2 + t9);
    t10 = *((unsigned char *)t1);
    t11 = (t0 + 8304);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t10;
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t16 = (t0 + 7792);
    *((int *)t16) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1532286746_0000452272_p_7(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(175, ng0);

LAB3:    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t1 = (t0 + 4168U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 1);
    t6 = (t5 - 24);
    t7 = (t6 * -1);
    t8 = (1U * t7);
    t9 = (0 + t8);
    t1 = (t2 + t9);
    t10 = *((unsigned char *)t1);
    t11 = (t0 + 8368);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t10;
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t16 = (t0 + 7808);
    *((int *)t16) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1532286746_0000452272_p_8(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(176, ng0);

LAB3:    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t1 = (t0 + 4168U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 1);
    t6 = (t5 - 24);
    t7 = (t6 * -1);
    t8 = (1U * t7);
    t9 = (0 + t8);
    t1 = (t2 + t9);
    t10 = *((unsigned char *)t1);
    t11 = (t0 + 8432);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = t10;
    xsi_driver_first_trans_fast_port(t11);

LAB2:    t16 = (t0 + 7824);
    *((int *)t16) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1532286746_0000452272_p_9(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    int t6;
    int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;

LAB0:    xsi_set_current_line(177, ng0);

LAB3:    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t1 = (t0 + 4168U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 / 2);
    t6 = (t5 - 1);
    t7 = (t6 - 11);
    t8 = (t7 * -1);
    t9 = (1U * t8);
    t10 = (0 + t9);
    t1 = (t2 + t10);
    t11 = *((unsigned char *)t1);
    t12 = (t0 + 8496);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = t11;
    xsi_driver_first_trans_fast_port(t12);

LAB2:    t17 = (t0 + 7840);
    *((int *)t17) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_1532286746_0000452272_init()
{
	static char *pe[] = {(void *)work_a_1532286746_0000452272_p_0,(void *)work_a_1532286746_0000452272_p_1,(void *)work_a_1532286746_0000452272_p_2,(void *)work_a_1532286746_0000452272_p_3,(void *)work_a_1532286746_0000452272_p_4,(void *)work_a_1532286746_0000452272_p_5,(void *)work_a_1532286746_0000452272_p_6,(void *)work_a_1532286746_0000452272_p_7,(void *)work_a_1532286746_0000452272_p_8,(void *)work_a_1532286746_0000452272_p_9};
	xsi_register_didat("work_a_1532286746_0000452272", "isim/appsfpga_tb_isim_beh.exe.sim/work/a_1532286746_0000452272.didat");
	xsi_register_executes(pe);
}
