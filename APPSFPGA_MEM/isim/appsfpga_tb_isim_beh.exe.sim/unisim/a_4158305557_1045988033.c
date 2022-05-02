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
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_13554554585326073636_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_3488546069778340532_503743352(char *, unsigned char , unsigned char );


static void unisim_a_4158305557_1045988033_p_0(char *t0)
{
    int64 t1;
    char *t2;
    char *t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:
LAB3:    t1 = (0 * 1LL);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t2 = (t0 + 8840);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_delta(t2, 0U, 1, t1);
    t9 = (t0 + 8840);
    xsi_driver_intertial_reject(t9, t1, t1);

LAB2:    t10 = (t0 + 8616);
    *((int *)t10) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void unisim_a_4158305557_1045988033_p_1(char *t0)
{
    int64 t1;
    char *t2;
    char *t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:
LAB3:    t1 = (0 * 1LL);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t2 = (t0 + 8904);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_delta(t2, 0U, 1, t1);
    t9 = (t0 + 8904);
    xsi_driver_intertial_reject(t9, t1, t1);

LAB2:    t10 = (t0 + 8632);
    *((int *)t10) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void unisim_a_4158305557_1045988033_p_2(char *t0)
{
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

LAB0:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t2 = (t0 + 2792U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    t1 = t8;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB10;

LAB11:    t1 = (unsigned char)0;

LAB12:    if (t1 != 0)
        goto LAB8;

LAB9:
LAB3:    t2 = (t0 + 8648);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    t2 = (t0 + 8968);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

LAB5:    t1 = (unsigned char)1;
    goto LAB7;

LAB8:    t2 = (t0 + 8968);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB3;

LAB10:    t2 = (t0 + 2792U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;
    goto LAB12;

}

static void unisim_a_4158305557_1045988033_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    int64 t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int64 t11;
    int64 t12;
    int64 t13;
    int64 t14;
    int64 t15;
    int64 t16;
    unsigned char t17;
    int64 t18;
    int64 t19;
    int64 t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    unsigned char t25;
    unsigned char t26;
    unsigned char t27;

LAB0:    t1 = (t0 + 6808U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB4;

LAB6:    t2 = (t0 + 1952U);
    t4 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t4 != 0)
        goto LAB7;

LAB8:
LAB5:
LAB30:    t2 = (t0 + 8664);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB31;

LAB1:    return;
LAB4:    t6 = (0 * 1LL);
    t2 = (t0 + 9032);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((int64 *)t10) = t6;
    xsi_driver_first_trans_fast(t2);
    goto LAB5;

LAB7:    t3 = (t0 + 5088U);
    t7 = *((char **)t3);
    t6 = *((int64 *)t7);
    t3 = (t0 + 4968U);
    t8 = *((char **)t3);
    t3 = (t8 + 0);
    *((int64 *)t3) = t6;
    t6 = xsi_get_sim_current_time();
    t2 = (t0 + 5088U);
    t3 = *((char **)t2);
    t2 = (t3 + 0);
    *((int64 *)t2) = t6;
    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t6 = *((int64 *)t3);
    t11 = (0 * 1LL);
    t5 = (t6 != t11);
    if (t5 == 1)
        goto LAB12;

LAB13:    t4 = (unsigned char)0;

LAB14:    if (t4 != 0)
        goto LAB9;

LAB11:    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t6 = *((int64 *)t3);
    t11 = (0 * 1LL);
    t5 = (t6 != t11);
    if (t5 == 1)
        goto LAB17;

LAB18:    t4 = (unsigned char)0;

LAB19:    if (t4 != 0)
        goto LAB15;

LAB16:    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t6 = *((int64 *)t3);
    t11 = (0 * 1LL);
    t17 = (t6 == t11);
    if (t17 == 1)
        goto LAB25;

LAB26:    t5 = (unsigned char)0;

LAB27:    if (t5 == 1)
        goto LAB22;

LAB23:    t4 = (unsigned char)0;

LAB24:    if (t4 != 0)
        goto LAB20;

LAB21:
LAB10:    goto LAB5;

LAB9:    t18 = xsi_get_sim_current_time();
    t2 = (t0 + 4968U);
    t10 = *((char **)t2);
    t19 = *((int64 *)t10);
    t20 = (t18 - t19);
    t2 = (t0 + 9032);
    t21 = (t2 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    *((int64 *)t24) = t20;
    xsi_driver_first_trans_fast(t2);
    goto LAB10;

LAB12:    t2 = (t0 + 5088U);
    t7 = *((char **)t2);
    t12 = *((int64 *)t7);
    t2 = (t0 + 4968U);
    t8 = *((char **)t2);
    t13 = *((int64 *)t8);
    t14 = (t12 - t13);
    t2 = (t0 + 2632U);
    t9 = *((char **)t2);
    t15 = *((int64 *)t9);
    t16 = (1.5000000000000000 * t15);
    t17 = (t14 <= t16);
    t4 = t17;
    goto LAB14;

LAB15:    t18 = (0 * 1LL);
    t2 = (t0 + 9032);
    t9 = (t2 + 56U);
    t10 = *((char **)t9);
    t21 = (t10 + 56U);
    t22 = *((char **)t21);
    *((int64 *)t22) = t18;
    xsi_driver_first_trans_fast(t2);
    goto LAB10;

LAB17:    t12 = xsi_get_sim_current_time();
    t2 = (t0 + 4968U);
    t7 = *((char **)t2);
    t13 = *((int64 *)t7);
    t14 = (t12 - t13);
    t2 = (t0 + 2632U);
    t8 = *((char **)t2);
    t15 = *((int64 *)t8);
    t16 = (1.5000000000000000 * t15);
    t17 = (t14 > t16);
    t4 = t17;
    goto LAB19;

LAB20:    t14 = xsi_get_sim_current_time();
    t2 = (t0 + 4968U);
    t9 = *((char **)t2);
    t15 = *((int64 *)t9);
    t16 = (t14 - t15);
    t2 = (t0 + 9032);
    t10 = (t2 + 56U);
    t21 = *((char **)t10);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    *((int64 *)t23) = t16;
    xsi_driver_first_trans_fast(t2);
    goto LAB10;

LAB22:    t2 = (t0 + 4392U);
    t8 = *((char **)t2);
    t26 = *((unsigned char *)t8);
    t27 = (t26 == (unsigned char)3);
    t4 = t27;
    goto LAB24;

LAB25:    t2 = (t0 + 4968U);
    t7 = *((char **)t2);
    t12 = *((int64 *)t7);
    t13 = (0 * 1LL);
    t25 = (t12 != t13);
    t5 = t25;
    goto LAB27;

LAB28:    t3 = (t0 + 8664);
    *((int *)t3) = 0;
    goto LAB2;

LAB29:    goto LAB28;

LAB31:    goto LAB29;

}

static void unisim_a_4158305557_1045988033_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    t1 = (t0 + 7056U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB4;

LAB6:    t2 = (t0 + 1952U);
    t4 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t4 != 0)
        goto LAB7;

LAB9:
LAB8:    t2 = (t0 + 1952U);
    t4 = ieee_p_2592010699_sub_13554554585326073636_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t4 != 0)
        goto LAB10;

LAB12:
LAB11:
LAB5:
LAB15:    t2 = (t0 + 8680);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB16;

LAB1:    return;
LAB4:    t2 = (t0 + 9096);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9160);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9224);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9288);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB5;

LAB7:    t3 = (t0 + 9096);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t3);
    t2 = (t0 + 9160);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9224);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9288);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB8;

LAB10:    t3 = (t0 + 9160);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t3);
    t2 = (t0 + 9096);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9224);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9288);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB11;

LAB13:    t3 = (t0 + 8680);
    *((int *)t3) = 0;
    goto LAB2;

LAB14:    goto LAB13;

LAB16:    goto LAB14;

}

static void unisim_a_4158305557_1045988033_p_5(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    t1 = (t0 + 7304U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB4;

LAB6:    t2 = (t0 + 1952U);
    t4 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t4 != 0)
        goto LAB7;

LAB9:
LAB8:    t2 = (t0 + 1952U);
    t4 = ieee_p_2592010699_sub_13554554585326073636_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t4 != 0)
        goto LAB10;

LAB12:
LAB11:
LAB5:
LAB15:    t2 = (t0 + 8696);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB16;

LAB1:    return;
LAB4:    t2 = (t0 + 9352);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    t2 = (t0 + 9416);
    t3 = (t2 + 56U);
    t6 = *((char **)t3);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB5;

LAB7:    t3 = (t0 + 9352);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast(t3);
    goto LAB8;

LAB10:    t3 = (t0 + 9416);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast(t3);
    goto LAB11;

LAB13:    t3 = (t0 + 8696);
    *((int *)t3) = 0;
    goto LAB2;

LAB14:    goto LAB13;

LAB16:    goto LAB14;

}

static void unisim_a_4158305557_1045988033_p_6(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    int64 t11;
    int64 t12;
    double t13;
    unsigned char t14;
    unsigned char t15;
    unsigned char t16;
    unsigned char t17;
    unsigned char t18;
    char *t19;
    char *t20;

LAB0:    t1 = (t0 + 7552U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB4;

LAB6:    t2 = (t0 + 4392U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB7;

LAB9:
LAB8:
LAB5:
LAB35:    t2 = (t0 + 8712);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB36;

LAB1:    return;
LAB4:    t2 = (t0 + 9480);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB5;

LAB7:    t2 = (t0 + 1952U);
    t10 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t10 != 0)
        goto LAB10;

LAB12:
LAB11:    goto LAB8;

LAB10:    t11 = (1 * 1LL);
    t6 = (t0 + 7360);
    xsi_process_wait(t6, t11);

LAB15:    *((char **)t1) = &&LAB16;
    goto LAB1;

LAB13:    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t11 = *((int64 *)t3);
    t12 = (0 * 1LL);
    t4 = (t11 != t12);
    if (t4 != 0)
        goto LAB17;

LAB19:
LAB18:    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t11 = *((int64 *)t3);
    t13 = (9.0999999999999996 / 10.000000000000000);
    t12 = (t11 * t13);
    t2 = (t0 + 7360);
    xsi_process_wait(t2, t12);

LAB22:    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB14:    goto LAB13;

LAB16:    goto LAB14;

LAB17:    t2 = (t0 + 9480);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB18;

LAB20:    t2 = (t0 + 4072U);
    t3 = *((char **)t2);
    t10 = *((unsigned char *)t3);
    t14 = (t10 != (unsigned char)3);
    if (t14 == 1)
        goto LAB30;

LAB31:    t5 = (unsigned char)0;

LAB32:    if (t5 == 1)
        goto LAB27;

LAB28:    t4 = (unsigned char)0;

LAB29:    if (t4 != 0)
        goto LAB24;

LAB26:
LAB25:    goto LAB11;

LAB21:    goto LAB20;

LAB23:    goto LAB21;

LAB24:    t2 = (t0 + 9480);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t19 = (t9 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB25;

LAB27:    t2 = (t0 + 2152U);
    t7 = *((char **)t2);
    t17 = *((unsigned char *)t7);
    t18 = (t17 == (unsigned char)2);
    t4 = t18;
    goto LAB29;

LAB30:    t2 = (t0 + 3432U);
    t6 = *((char **)t2);
    t15 = *((unsigned char *)t6);
    t16 = (t15 != (unsigned char)3);
    t5 = t16;
    goto LAB32;

LAB33:    t3 = (t0 + 8712);
    *((int *)t3) = 0;
    goto LAB2;

LAB34:    goto LAB33;

LAB36:    goto LAB34;

}

static void unisim_a_4158305557_1045988033_p_7(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    int64 t11;
    int64 t12;
    unsigned char t13;
    char *t14;
    char *t15;
    double t16;
    unsigned char t17;
    unsigned char t18;
    unsigned char t19;
    unsigned char t20;

LAB0:    t1 = (t0 + 7800U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB4;

LAB6:    t2 = (t0 + 4552U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 != 0)
        goto LAB7;

LAB9:
LAB8:
LAB5:
LAB31:    t2 = (t0 + 8728);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB32;

LAB1:    return;
LAB4:    t2 = (t0 + 9544);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB5;

LAB7:    t2 = (t0 + 1952U);
    t10 = ieee_p_2592010699_sub_13554554585326073636_503743352(IEEE_P_2592010699, t2, 0U, 0U);
    if (t10 != 0)
        goto LAB10;

LAB12:
LAB11:    goto LAB8;

LAB10:    t6 = (t0 + 2632U);
    t7 = *((char **)t6);
    t11 = *((int64 *)t7);
    t12 = (0 * 1LL);
    t13 = (t11 != t12);
    if (t13 != 0)
        goto LAB13;

LAB15:
LAB14:    t2 = (t0 + 2632U);
    t3 = *((char **)t2);
    t11 = *((int64 *)t3);
    t16 = (9.0999999999999996 / 10.000000000000000);
    t12 = (t11 * t16);
    t2 = (t0 + 7608);
    xsi_process_wait(t2, t12);

LAB18:    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    t6 = (t0 + 9544);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    t14 = (t9 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)2;
    xsi_driver_first_trans_fast(t6);
    goto LAB14;

LAB16:    t2 = (t0 + 4232U);
    t3 = *((char **)t2);
    t10 = *((unsigned char *)t3);
    t13 = (t10 != (unsigned char)3);
    if (t13 == 1)
        goto LAB26;

LAB27:    t5 = (unsigned char)0;

LAB28:    if (t5 == 1)
        goto LAB23;

LAB24:    t4 = (unsigned char)0;

LAB25:    if (t4 != 0)
        goto LAB20;

LAB22:
LAB21:    goto LAB11;

LAB17:    goto LAB16;

LAB19:    goto LAB17;

LAB20:    t2 = (t0 + 9544);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t14 = (t9 + 56U);
    t15 = *((char **)t14);
    *((unsigned char *)t15) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB21;

LAB23:    t2 = (t0 + 2152U);
    t7 = *((char **)t2);
    t19 = *((unsigned char *)t7);
    t20 = (t19 == (unsigned char)2);
    t4 = t20;
    goto LAB25;

LAB26:    t2 = (t0 + 3272U);
    t6 = *((char **)t2);
    t17 = *((unsigned char *)t6);
    t18 = (t17 != (unsigned char)3);
    t5 = t18;
    goto LAB28;

LAB29:    t3 = (t0 + 8728);
    *((int *)t3) = 0;
    goto LAB2;

LAB30:    goto LAB29;

LAB32:    goto LAB30;

}

static void unisim_a_4158305557_1045988033_p_8(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    t1 = (t0 + 8048U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 2952U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t2 = (t0 + 3112U);
    t5 = *((char **)t2);
    t6 = *((unsigned char *)t5);
    t7 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t4, t6);
    t2 = (t0 + 9608);
    t8 = (t2 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = t7;
    xsi_driver_first_trans_fast(t2);

LAB6:    t2 = (t0 + 8744);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    t3 = (t0 + 8744);
    *((int *)t3) = 0;
    goto LAB2;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

}

static void unisim_a_4158305557_1045988033_p_9(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;

LAB0:    t1 = (t0 + 4848U);
    t2 = *((char **)t1);
    t3 = *((int64 *)t2);
    t1 = (t0 + 2312U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t1 = (t0 + 9672);
    t6 = (t1 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t5;
    xsi_driver_first_trans_delta(t1, 0U, 1, t3);
    t10 = (t0 + 9672);
    xsi_driver_intertial_reject(t10, t3, t3);
    t1 = (t0 + 8760);
    *((int *)t1) = 1;

LAB1:    return;
}


extern void unisim_a_4158305557_1045988033_init()
{
	static char *pe[] = {(void *)unisim_a_4158305557_1045988033_p_0,(void *)unisim_a_4158305557_1045988033_p_1,(void *)unisim_a_4158305557_1045988033_p_2,(void *)unisim_a_4158305557_1045988033_p_3,(void *)unisim_a_4158305557_1045988033_p_4,(void *)unisim_a_4158305557_1045988033_p_5,(void *)unisim_a_4158305557_1045988033_p_6,(void *)unisim_a_4158305557_1045988033_p_7,(void *)unisim_a_4158305557_1045988033_p_8,(void *)unisim_a_4158305557_1045988033_p_9};
	xsi_register_didat("unisim_a_4158305557_1045988033", "isim/appsfpga_tb_isim_beh.exe.sim/unisim/a_4158305557_1045988033.didat");
	xsi_register_executes(pe);
}
