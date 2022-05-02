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
static const char *ng0 = "/home/ise/ise_proj/dmd-project/APPSFPGA_MEM/src/rtl/cnts_a_1and0clks.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_3488768496604610246_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );
char *ieee_p_3620187407_sub_2255506239096166994_3965413181(char *, char *, char *, char *, int );


static void work_a_2631707262_3212880686_p_0(char *t0)
{
    char *t1;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(35, ng0);

LAB3:    t1 = (t0 + 11527);
    t3 = (t0 + 6936);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:
LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_2631707262_3212880686_p_1(char *t0)
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

LAB0:    xsi_set_current_line(40, ng0);
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
LAB3:    t1 = (t0 + 6760);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 11531);
    t6 = (t0 + 7000);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 5U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(43, ng0);
    t5 = (t0 + 1512U);
    t6 = *((char **)t5);
    t5 = (t0 + 11296U);
    t7 = (t0 + 11536);
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

LAB12:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 11296U);
    t5 = (t0 + 11545);
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

LAB14:    t1 = (t0 + 1512U);
    t2 = *((char **)t1);
    t1 = (t0 + 11296U);
    t5 = (t0 + 11554);
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

LAB16:    xsi_set_current_line(50, ng0);
    t17 = (1 * 1LL);
    t1 = (t0 + 11563);
    t5 = (t0 + 7000);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 5U);
    xsi_driver_first_trans_delta(t5, 0U, 5U, t17);
    t10 = (t0 + 7000);
    xsi_driver_intertial_reject(t10, t17, t17);

LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t12 = xsi_signal_has_event(t1);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(44, ng0);
    t17 = (1 * 1LL);
    t10 = (t0 + 11540);
    t19 = (t0 + 7000);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    memcpy(t23, t10, 5U);
    xsi_driver_first_trans_delta(t19, 0U, 5U, t17);
    t24 = (t0 + 7000);
    xsi_driver_intertial_reject(t24, t17, t17);
    goto LAB11;

LAB13:    xsi_set_current_line(46, ng0);
    t17 = (1 * 1LL);
    t8 = (t0 + 11549);
    t10 = (t0 + 7000);
    t18 = (t10 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 5U);
    xsi_driver_first_trans_delta(t10, 0U, 5U, t17);
    t22 = (t0 + 7000);
    xsi_driver_intertial_reject(t22, t17, t17);
    goto LAB11;

LAB15:    xsi_set_current_line(48, ng0);
    t17 = (1 * 1LL);
    t8 = (t0 + 11558);
    t10 = (t0 + 7000);
    t18 = (t10 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 5U);
    xsi_driver_first_trans_delta(t10, 0U, 5U, t17);
    t22 = (t0 + 7000);
    xsi_driver_intertial_reject(t22, t17, t17);
    goto LAB11;

}

static void work_a_2631707262_3212880686_p_2(char *t0)
{
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
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;

LAB0:    xsi_set_current_line(58, ng0);
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
LAB3:    t1 = (t0 + 6776);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 11568);
    t6 = (t0 + 7064);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 4U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(61, ng0);
    t5 = (t0 + 7064);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_delta(t5, 3U, 1, 0LL);
    xsi_set_current_line(62, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t13 = (0 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t3 = *((unsigned char *)t1);
    t5 = (t0 + 7064);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_delta(t5, 2U, 1, 0LL);
    xsi_set_current_line(63, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t13 = (1 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t3 = *((unsigned char *)t1);
    t5 = (t0 + 7064);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_delta(t5, 1U, 1, 0LL);
    xsi_set_current_line(64, ng0);
    t1 = (t0 + 3272U);
    t2 = *((char **)t1);
    t13 = (2 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t1 = (t2 + t16);
    t3 = *((unsigned char *)t1);
    t5 = (t0 + 7064);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t3;
    xsi_driver_first_trans_delta(t5, 0U, 1, 0LL);
    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t12 = xsi_signal_has_event(t1);
    t3 = t12;
    goto LAB9;

}

static void work_a_2631707262_3212880686_p_3(char *t0)
{
    char t23[16];
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
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;
    int64 t22;

LAB0:    xsi_set_current_line(72, ng0);
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
LAB3:    t1 = (t0 + 6792);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 11572);
    t6 = (t0 + 7128);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 5U);
    xsi_driver_first_trans_fast(t6);
    goto LAB3;

LAB5:    xsi_set_current_line(75, ng0);
    t5 = (t0 + 3272U);
    t6 = *((char **)t5);
    t13 = (3 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t5 = (t6 + t16);
    t17 = *((unsigned char *)t5);
    t18 = (t17 == (unsigned char)2);
    if (t18 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 11360U);
    t5 = (t0 + 3112U);
    t6 = *((char **)t5);
    t5 = (t0 + 11392U);
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t6, t5);
    if (t3 != 0)
        goto LAB13;

LAB15:    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB16;

LAB17:
LAB14:
LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t12 = xsi_signal_has_event(t1);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(76, ng0);
    t7 = (t0 + 11577);
    t9 = (t0 + 7128);
    t10 = (t9 + 56U);
    t19 = *((char **)t10);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 5U);
    xsi_driver_first_trans_fast(t9);
    goto LAB11;

LAB13:    xsi_set_current_line(80, ng0);
    t7 = (t0 + 11582);
    t9 = (t0 + 7128);
    t10 = (t9 + 56U);
    t19 = *((char **)t10);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 5U);
    xsi_driver_first_trans_fast(t9);
    goto LAB14;

LAB16:    xsi_set_current_line(82, ng0);
    t22 = (1 * 1LL);
    t1 = (t0 + 2312U);
    t5 = *((char **)t1);
    t1 = (t0 + 11360U);
    t6 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t23, t5, t1, 1);
    t7 = (t23 + 12U);
    t14 = *((unsigned int *)t7);
    t15 = (1U * t14);
    t11 = (5U != t15);
    if (t11 == 1)
        goto LAB18;

LAB19:    t8 = (t0 + 7128);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t19 = (t10 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t6, 5U);
    xsi_driver_first_trans_delta(t8, 0U, 5U, t22);
    t21 = (t0 + 7128);
    xsi_driver_intertial_reject(t21, t22, t22);
    goto LAB14;

LAB18:    xsi_size_not_matching(5U, t15, 0);
    goto LAB19;

}

static void work_a_2631707262_3212880686_p_4(char *t0)
{
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
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(92, ng0);
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
LAB3:    t1 = (t0 + 6808);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(93, ng0);
    t1 = xsi_get_transient_memory(5U);
    memset(t1, 0, 5U);
    t5 = t1;
    memset(t5, (unsigned char)2, 5U);
    t6 = (t0 + 7192);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 5U);
    xsi_driver_first_trans_fast_port(t6);
    xsi_set_current_line(94, ng0);
    t1 = (t0 + 7256);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(96, ng0);
    t5 = (t0 + 3272U);
    t6 = *((char **)t5);
    t13 = (3 - 3);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t5 = (t6 + t16);
    t17 = *((unsigned char *)t5);
    t18 = (t17 == (unsigned char)2);
    if (t18 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(101, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 7192);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 5U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(102, ng0);
    t1 = (t0 + 7256);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t1);

LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t12 = xsi_signal_has_event(t1);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(97, ng0);
    t7 = xsi_get_transient_memory(5U);
    memset(t7, 0, 5U);
    t8 = t7;
    memset(t8, (unsigned char)2, 5U);
    t9 = (t0 + 7192);
    t10 = (t9 + 56U);
    t19 = *((char **)t10);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t7, 5U);
    xsi_driver_first_trans_fast_port(t9);
    xsi_set_current_line(98, ng0);
    t1 = (t0 + 7256);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB11;

}

static void work_a_2631707262_3212880686_p_5(char *t0)
{
    char t20[16];
    char t22[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    unsigned int t21;
    int t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    xsi_set_current_line(112, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t9 = (t4 == (unsigned char)3);
    if (t9 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 6824);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(113, ng0);
    t1 = (t0 + 7320);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(114, ng0);
    t1 = (t0 + 7384);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(116, ng0);
    t5 = (t0 + 3272U);
    t6 = *((char **)t5);
    t11 = (3 - 3);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t5 = (t6 + t14);
    t15 = *((unsigned char *)t5);
    t16 = (t15 == (unsigned char)2);
    if (t16 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(120, ng0);
    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t12 = (26 - 10);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t1 = (t2 + t14);
    t5 = (t20 + 0U);
    t6 = (t5 + 0U);
    *((int *)t6) = 10;
    t6 = (t5 + 4U);
    *((int *)t6) = 0;
    t6 = (t5 + 8U);
    *((int *)t6) = -1;
    t11 = (0 - 10);
    t21 = (t11 * -1);
    t21 = (t21 + 1);
    t6 = (t5 + 12U);
    *((unsigned int *)t6) = t21;
    t6 = (t0 + 11587);
    t8 = (t22 + 0U);
    t17 = (t8 + 0U);
    *((int *)t17) = 0;
    t17 = (t8 + 4U);
    *((int *)t17) = 10;
    t17 = (t8 + 8U);
    *((int *)t17) = 1;
    t23 = (10 - 0);
    t21 = (t23 * 1);
    t21 = (t21 + 1);
    t17 = (t8 + 12U);
    *((unsigned int *)t17) = t21;
    t4 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t1, t20, t6, t22);
    if (t4 == 1)
        goto LAB16;

LAB17:    t3 = (unsigned char)0;

LAB18:    if (t3 != 0)
        goto LAB13;

LAB15:
LAB14:    xsi_set_current_line(124, ng0);
    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3432U);
    t5 = *((char **)t1);
    t4 = *((unsigned char *)t5);
    t9 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t4);
    t10 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t3, t9);
    t1 = (t0 + 7320);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t17 = *((char **)t8);
    *((unsigned char *)t17) = t10;
    xsi_driver_first_trans_fast_port(t1);

LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t10 = xsi_signal_has_event(t1);
    t3 = t10;
    goto LAB9;

LAB10:    xsi_set_current_line(117, ng0);
    t7 = (t0 + 7320);
    t8 = (t7 + 56U);
    t17 = *((char **)t8);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t7);
    xsi_set_current_line(118, ng0);
    t1 = (t0 + 7384);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    goto LAB11;

LAB13:    xsi_set_current_line(121, ng0);
    t25 = (t0 + 1352U);
    t26 = *((char **)t25);
    t10 = *((unsigned char *)t26);
    t25 = (t0 + 7384);
    t27 = (t25 + 56U);
    t28 = *((char **)t27);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    *((unsigned char *)t30) = t10;
    xsi_driver_first_trans_fast(t25);
    goto LAB14;

LAB16:    t17 = (t0 + 2312U);
    t18 = *((char **)t17);
    t17 = (t0 + 11360U);
    t19 = (t0 + 3112U);
    t24 = *((char **)t19);
    t19 = (t0 + 11392U);
    t9 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t18, t17, t24, t19);
    t3 = t9;
    goto LAB18;

}

static void work_a_2631707262_3212880686_p_6(char *t0)
{
    char t22[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    int64 t20;
    char *t21;
    char *t23;

LAB0:    xsi_set_current_line(134, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t9 = (t4 == (unsigned char)3);
    if (t9 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 6840);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(135, ng0);
    t1 = (t0 + 7448);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(136, ng0);
    t1 = (t0 + 7512);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(137, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t1 = (t0 + 7576);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 27U);
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(139, ng0);
    t5 = (t0 + 3272U);
    t6 = *((char **)t5);
    t11 = (3 - 3);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t5 = (t6 + t14);
    t15 = *((unsigned char *)t5);
    t16 = (t15 == (unsigned char)2);
    if (t16 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(145, ng0);
    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t1 = (t0 + 11360U);
    t5 = (t0 + 3112U);
    t6 = *((char **)t5);
    t5 = (t0 + 11392U);
    t3 = ieee_std_logic_unsigned_equal_stdv_stdv(IEEE_P_3620187407, t2, t1, t6, t5);
    if (t3 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(148, ng0);
    t20 = (1 * 1LL);
    t1 = (t0 + 7448);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_delta(t1, 0U, 1, t20);
    t8 = (t0 + 7448);
    xsi_driver_intertial_reject(t8, t20, t20);

LAB14:    xsi_set_current_line(150, ng0);
    t20 = (1 * 1LL);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 7512);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t3;
    xsi_driver_first_trans_delta(t1, 0U, 1, t20);
    t17 = (t0 + 7512);
    xsi_driver_intertial_reject(t17, t20, t20);
    xsi_set_current_line(152, ng0);
    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB16;

LAB18:
LAB17:
LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t10 = xsi_signal_has_event(t1);
    t3 = t10;
    goto LAB9;

LAB10:    xsi_set_current_line(140, ng0);
    t7 = (t0 + 7448);
    t8 = (t7 + 56U);
    t17 = *((char **)t8);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(141, ng0);
    t1 = (t0 + 7512);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(142, ng0);
    t1 = (t0 + 3728U);
    t2 = *((char **)t1);
    t1 = (t0 + 7576);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t2, 27U);
    xsi_driver_first_trans_fast(t1);
    goto LAB11;

LAB13:    xsi_set_current_line(146, ng0);
    t20 = (1 * 1LL);
    t7 = (t0 + 7448);
    t8 = (t7 + 56U);
    t17 = *((char **)t8);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)3;
    xsi_driver_first_trans_delta(t7, 0U, 1, t20);
    t21 = (t0 + 7448);
    xsi_driver_intertial_reject(t21, t20, t20);
    goto LAB14;

LAB16:    xsi_set_current_line(153, ng0);
    t20 = (1 * 1LL);
    t1 = (t0 + 2632U);
    t5 = *((char **)t1);
    t1 = (t0 + 11376U);
    t6 = ieee_p_3620187407_sub_2255506239096166994_3965413181(IEEE_P_3620187407, t22, t5, t1, 1);
    t7 = (t22 + 12U);
    t12 = *((unsigned int *)t7);
    t13 = (1U * t12);
    t9 = (27U != t13);
    if (t9 == 1)
        goto LAB19;

LAB20:    t8 = (t0 + 7576);
    t17 = (t8 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t21 = *((char **)t19);
    memcpy(t21, t6, 27U);
    xsi_driver_first_trans_delta(t8, 0U, 27U, t20);
    t23 = (t0 + 7576);
    xsi_driver_intertial_reject(t23, t20, t20);
    goto LAB17;

LAB19:    xsi_size_not_matching(27U, t13, 0);
    goto LAB20;

}

static void work_a_2631707262_3212880686_p_7(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(160, ng0);

LAB3:    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 7640);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 27U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 6856);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_2631707262_3212880686_init()
{
	static char *pe[] = {(void *)work_a_2631707262_3212880686_p_0,(void *)work_a_2631707262_3212880686_p_1,(void *)work_a_2631707262_3212880686_p_2,(void *)work_a_2631707262_3212880686_p_3,(void *)work_a_2631707262_3212880686_p_4,(void *)work_a_2631707262_3212880686_p_5,(void *)work_a_2631707262_3212880686_p_6,(void *)work_a_2631707262_3212880686_p_7};
	xsi_register_didat("work_a_2631707262_3212880686", "isim/appsfpga_tb_isim_beh.exe.sim/work/a_2631707262_3212880686.didat");
	xsi_register_executes(pe);
}
