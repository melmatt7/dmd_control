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
static const char *ng1 = "/home/ise/ise_proj/dmd-project/APPSFPGA_MEM/ipcore_dir/mig_top/user_design/rtl/ddr2_usr_rd.vhd";

unsigned char ieee_p_2592010699_sub_2763492388968962707_503743352(char *, char *, unsigned int , unsigned int );
unsigned char ieee_p_2592010699_sub_3488546069778340532_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_374109322130769762_503743352(char *, unsigned char );


unsigned char work_a_0922168953_0000452272_sub_12783214423863137252_4251431050(char *t1, char *t2, char *t3)
{
    char t4[128];
    char t5[24];
    char t9[8];
    unsigned char t0;
    char *t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    char *t12;
    unsigned char t13;
    char *t14;
    char *t15;
    int t16;
    char *t17;
    int t18;
    char *t19;
    int t20;
    int t21;
    int t22;
    int t23;
    int t24;
    char *t25;
    char *t26;
    unsigned char t27;
    int t28;
    char *t29;
    int t30;
    int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    unsigned char t36;
    unsigned char t37;
    char *t38;
    char *t39;

LAB0:    t6 = (t4 + 4U);
    t7 = ((IEEE_P_2592010699) + 3312);
    t8 = (t6 + 88U);
    *((char **)t8) = t7;
    t10 = (t6 + 56U);
    *((char **)t10) = t9;
    *((unsigned char *)t9) = (unsigned char)2;
    t11 = (t6 + 80U);
    *((unsigned int *)t11) = 1U;
    t12 = (t5 + 4U);
    t13 = (t2 != 0);
    if (t13 == 1)
        goto LAB3;

LAB2:    t14 = (t5 + 12U);
    *((char **)t14) = t3;
    t15 = (t3 + 8U);
    t16 = *((int *)t15);
    t17 = (t3 + 4U);
    t18 = *((int *)t17);
    t19 = (t3 + 0U);
    t20 = *((int *)t19);
    t21 = t20;
    t22 = t18;

LAB4:    t23 = (t22 * t16);
    t24 = (t21 * t16);
    if (t24 <= t23)
        goto LAB5;

LAB7:    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t13 = *((unsigned char *)t8);
    t0 = t13;

LAB1:    return t0;
LAB3:    *((char **)t12) = t2;
    goto LAB2;

LAB5:    t25 = (t6 + 56U);
    t26 = *((char **)t25);
    t27 = *((unsigned char *)t26);
    t25 = (t3 + 0U);
    t28 = *((int *)t25);
    t29 = (t3 + 8U);
    t30 = *((int *)t29);
    t31 = (t21 - t28);
    t32 = (t31 * t30);
    t33 = (1U * t32);
    t34 = (0 + t33);
    t35 = (t2 + t34);
    t36 = *((unsigned char *)t35);
    t37 = ieee_p_2592010699_sub_3488546069778340532_503743352(IEEE_P_2592010699, t27, t36);
    t38 = (t6 + 56U);
    t39 = *((char **)t38);
    t38 = (t39 + 0);
    *((unsigned char *)t38) = t37;

LAB6:    if (t21 == t22)
        goto LAB7;

LAB8:    t18 = (t21 + t16);
    t21 = t18;
    goto LAB4;

LAB9:;
}

static void work_a_0922168953_0000452272_p_0(char *t0)
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

LAB0:    xsi_set_current_line(146, ng1);

LAB3:    t1 = (t0 + 10160U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = ieee_p_2592010699_sub_374109322130769762_503743352(IEEE_P_2592010699, t3);
    t1 = (t0 + 24096);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = t4;
    xsi_driver_first_trans_fast(t1);

LAB2:    t9 = (t0 + 23680);
    *((int *)t9) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_1(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(152, ng1);
    t1 = (t0 + 5480U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 23696);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(153, ng1);
    t3 = (t0 + 6320U);
    t4 = *((char **)t3);
    t3 = (t0 + 24160);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t4, 8U);
    xsi_driver_first_trans_fast(t3);
    xsi_set_current_line(154, ng1);
    t1 = (t0 + 6160U);
    t3 = *((char **)t1);
    t1 = (t0 + 24224);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 8U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(155, ng1);
    t1 = (t0 + 5840U);
    t3 = *((char **)t1);
    t1 = (t0 + 24288);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 64U);
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(156, ng1);
    t1 = (t0 + 6000U);
    t3 = *((char **)t1);
    t1 = (t0 + 24352);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 64U);
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

}

static void work_a_0922168953_0000452272_p_2(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    unsigned char t7;
    unsigned char t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned char t27;
    char *t28;
    char *t29;
    char *t30;
    char *t31;
    char *t32;
    char *t33;

LAB0:    xsi_set_current_line(179, ng1);
    t1 = (t0 + 7920U);
    t2 = *((char **)t1);
    t3 = (0 - 7);
    t4 = (t3 * -1);
    t5 = (1U * t4);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = *((unsigned char *)t1);
    t8 = (t7 == (unsigned char)3);
    if (t8 != 0)
        goto LAB3;

LAB4:
LAB5:    t21 = (t0 + 7120U);
    t22 = *((char **)t21);
    t23 = (0 - 7);
    t24 = (t23 * -1);
    t25 = (1U * t24);
    t26 = (0 + t25);
    t21 = (t22 + t26);
    t27 = *((unsigned char *)t21);
    t28 = (t0 + 24416);
    t29 = (t28 + 56U);
    t30 = *((char **)t29);
    t31 = (t30 + 56U);
    t32 = *((char **)t31);
    *((unsigned char *)t32) = t27;
    xsi_driver_first_trans_fast(t28);

LAB2:    t33 = (t0 + 23712);
    *((int *)t33) = 1;

LAB1:    return;
LAB3:    t9 = (t0 + 6160U);
    t10 = *((char **)t9);
    t11 = (0 - 7);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t9 = (t10 + t14);
    t15 = *((unsigned char *)t9);
    t16 = (t0 + 24416);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = t15;
    xsi_driver_first_trans_fast(t16);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16336U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 16336U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24480);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 56U, 8U, 0LL);

LAB2:    t41 = (t0 + 23728);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 16336U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24480);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 56U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16336U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 16336U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24544);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 56U, 8U, 0LL);

LAB2:    t41 = (t0 + 23744);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 16336U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24544);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 56U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_5(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16456U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 16456U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24608);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 48U, 8U, 0LL);

LAB2:    t41 = (t0 + 23760);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 16456U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24608);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 48U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_6(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16456U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 16456U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24672);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 48U, 8U, 0LL);

LAB2:    t41 = (t0 + 23776);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 16456U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24672);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 48U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_7(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16576U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 16576U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24736);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 40U, 8U, 0LL);

LAB2:    t41 = (t0 + 23792);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 16576U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24736);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 40U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_8(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16576U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 16576U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24800);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 40U, 8U, 0LL);

LAB2:    t41 = (t0 + 23808);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 16576U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24800);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 40U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_9(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16696U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 16696U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24864);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 32U, 8U, 0LL);

LAB2:    t41 = (t0 + 23824);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 16696U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24864);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 32U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_10(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16696U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 16696U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24928);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 32U, 8U, 0LL);

LAB2:    t41 = (t0 + 23840);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 16696U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24928);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 32U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_11(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16816U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 16816U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 24992);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 24U, 8U, 0LL);

LAB2:    t41 = (t0 + 23856);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 16816U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 24992);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 24U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_12(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16816U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 16816U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25056);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 24U, 8U, 0LL);

LAB2:    t41 = (t0 + 23872);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 16816U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25056);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 24U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_13(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16936U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 16936U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25120);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 16U, 8U, 0LL);

LAB2:    t41 = (t0 + 23888);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 16936U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25120);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 16U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_14(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 16936U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 16936U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25184);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 16U, 8U, 0LL);

LAB2:    t41 = (t0 + 23904);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 16936U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25184);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 16U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_15(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 17056U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 17056U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25248);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 8U, 8U, 0LL);

LAB2:    t41 = (t0 + 23920);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 17056U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25248);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 8U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_16(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 17056U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 17056U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25312);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 8U, 8U, 0LL);

LAB2:    t41 = (t0 + 23936);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 17056U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25312);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 8U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_17(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(184, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 17176U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7600U);
    t27 = *((char **)t26);
    t26 = (t0 + 17176U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25376);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 0U, 8U, 0LL);

LAB2:    t41 = (t0 + 23952);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 5840U);
    t12 = *((char **)t11);
    t11 = (t0 + 17176U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25376);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 0U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_18(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    int t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    int t14;
    int t15;
    int t16;
    int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    int t29;
    int t30;
    int t31;
    int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    char *t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;
    char *t41;

LAB0:    xsi_set_current_line(192, ng1);
    t1 = (t0 + 8080U);
    t2 = *((char **)t1);
    t1 = (t0 + 17176U);
    t3 = *((char **)t1);
    t4 = *((int *)t3);
    t5 = (t4 - 7);
    t6 = (t5 * -1);
    t7 = (1U * t6);
    t8 = (0 + t7);
    t1 = (t2 + t8);
    t9 = *((unsigned char *)t1);
    t10 = (t9 == (unsigned char)3);
    if (t10 != 0)
        goto LAB3;

LAB4:
LAB5:    t26 = (t0 + 7440U);
    t27 = *((char **)t26);
    t26 = (t0 + 17176U);
    t28 = *((char **)t26);
    t29 = *((int *)t28);
    t30 = (t29 * 8);
    t31 = (8 - 1);
    t32 = (t30 + t31);
    t33 = (63 - t32);
    t34 = (t33 * 1U);
    t35 = (0 + t34);
    t26 = (t27 + t35);
    t36 = (t0 + 25440);
    t37 = (t36 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    memcpy(t40, t26, 8U);
    xsi_driver_first_trans_delta(t36, 0U, 8U, 0LL);

LAB2:    t41 = (t0 + 23968);
    *((int *)t41) = 1;

LAB1:    return;
LAB3:    t11 = (t0 + 6000U);
    t12 = *((char **)t11);
    t11 = (t0 + 17176U);
    t13 = *((char **)t11);
    t14 = *((int *)t13);
    t15 = (t14 * 8);
    t16 = (8 - 1);
    t17 = (t15 + t16);
    t18 = (63 - t17);
    t19 = (t18 * 1U);
    t20 = (0 + t19);
    t11 = (t12 + t20);
    t21 = (t0 + 25440);
    t22 = (t21 + 56U);
    t23 = *((char **)t22);
    t24 = (t23 + 56U);
    t25 = *((char **)t24);
    memcpy(t25, t11, 8U);
    xsi_driver_first_trans_delta(t21, 0U, 8U, 0LL);
    goto LAB2;

LAB6:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_19(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    unsigned char t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;

LAB0:    xsi_set_current_line(205, ng1);
    t1 = (t0 + 5480U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 23984);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(206, ng1);
    t3 = (t0 + 5680U);
    t4 = *((char **)t3);
    t5 = *((unsigned char *)t4);
    t3 = (t0 + 25504);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = t5;
    xsi_driver_first_trans_fast(t3);
    goto LAB3;

}

static void work_a_0922168953_0000452272_p_20(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(328, ng1);

LAB3:    t1 = (t0 + 8720U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 25568);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 24000);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0922168953_0000452272_p_21(char *t0)
{
    char *t1;
    unsigned char t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(331, ng1);
    t1 = (t0 + 5480U);
    t2 = ieee_p_2592010699_sub_2763492388968962707_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t2 != 0)
        goto LAB2;

LAB4:
LAB3:    t1 = (t0 + 24016);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(332, ng1);
    t3 = (t0 + 8240U);
    t4 = *((char **)t3);
    t3 = (t0 + 25632);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    memcpy(t8, t4, 64U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(333, ng1);
    t1 = (t0 + 7280U);
    t3 = *((char **)t1);
    t1 = (t0 + 25696);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 64U);
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(334, ng1);
    t1 = (t0 + 7760U);
    t3 = *((char **)t1);
    t2 = *((unsigned char *)t3);
    t1 = (t0 + 25760);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t2;
    xsi_driver_first_trans_fast(t1);
    goto LAB3;

}


extern void work_a_0922168953_0000452272_init()
{
	static char *pe[] = {(void *)work_a_0922168953_0000452272_p_0,(void *)work_a_0922168953_0000452272_p_1,(void *)work_a_0922168953_0000452272_p_2,(void *)work_a_0922168953_0000452272_p_3,(void *)work_a_0922168953_0000452272_p_4,(void *)work_a_0922168953_0000452272_p_5,(void *)work_a_0922168953_0000452272_p_6,(void *)work_a_0922168953_0000452272_p_7,(void *)work_a_0922168953_0000452272_p_8,(void *)work_a_0922168953_0000452272_p_9,(void *)work_a_0922168953_0000452272_p_10,(void *)work_a_0922168953_0000452272_p_11,(void *)work_a_0922168953_0000452272_p_12,(void *)work_a_0922168953_0000452272_p_13,(void *)work_a_0922168953_0000452272_p_14,(void *)work_a_0922168953_0000452272_p_15,(void *)work_a_0922168953_0000452272_p_16,(void *)work_a_0922168953_0000452272_p_17,(void *)work_a_0922168953_0000452272_p_18,(void *)work_a_0922168953_0000452272_p_19,(void *)work_a_0922168953_0000452272_p_20,(void *)work_a_0922168953_0000452272_p_21};
	static char *se[] = {(void *)work_a_0922168953_0000452272_sub_12783214423863137252_4251431050};
	xsi_register_didat("work_a_0922168953_0000452272", "isim/appsfpga_tb_isim_beh.exe.sim/work/a_0922168953_0000452272.didat");
	xsi_register_executes(pe);
	xsi_register_subprogram_executes(se);
}
