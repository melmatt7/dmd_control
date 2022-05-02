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
static const char *ng0 = "Function get_wl_count ended without a return statement";
static const char *ng1 = "Function get_bsa_count ended without a return statement";
static const char *ng2 = "Function get_row_count ended without a return statement";



char *ddc4100_p_0656405902_sub_17828511227308977621_981821023(char *t1, char *t2, unsigned char t3)
{
    char t5[8];
    char *t0;
    char *t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    char *t13;

LAB0:    t6 = (t5 + 4U);
    *((unsigned char *)t6) = t3;
    t7 = (t3 == (unsigned char)0);
    if (t7 != 0)
        goto LAB2;

LAB4:    t7 = (t3 == (unsigned char)1);
    if (t7 != 0)
        goto LAB6;

LAB7:    t7 = (t3 == (unsigned char)2);
    if (t7 != 0)
        goto LAB9;

LAB10:    t7 = (t3 == (unsigned char)3);
    if (t7 != 0)
        goto LAB12;

LAB13:    t8 = (t1 + 6472);
    t0 = xsi_get_transient_memory(6U);
    memcpy(t0, t8, 6U);
    t10 = (t2 + 0U);
    t13 = (t10 + 0U);
    *((int *)t13) = 1;
    t13 = (t10 + 4U);
    *((int *)t13) = 6;
    t13 = (t10 + 8U);
    *((int *)t13) = 1;
    t11 = (6 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t13 = (t10 + 12U);
    *((unsigned int *)t13) = t12;

LAB1:    return t0;
LAB2:    t8 = (t1 + 1168U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(6U);
    memcpy(t0, t9, 6U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 5;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 5);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB3:    xsi_error(ng0);
    t0 = 0;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    t8 = (t1 + 1288U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(6U);
    memcpy(t0, t9, 6U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 5;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 5);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB8:    goto LAB3;

LAB9:    t8 = (t1 + 1408U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(6U);
    memcpy(t0, t9, 6U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 5;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 5);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB11:    goto LAB3;

LAB12:    t8 = (t1 + 1528U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(6U);
    memcpy(t0, t9, 6U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 5;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 5);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB14:    goto LAB3;

LAB15:    goto LAB3;

}

char *ddc4100_p_0656405902_sub_9916005613022380456_981821023(char *t1, char *t2, unsigned char t3)
{
    char t5[8];
    char *t0;
    char *t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    char *t13;

LAB0:    t6 = (t5 + 4U);
    *((unsigned char *)t6) = t3;
    t7 = (t3 == (unsigned char)0);
    if (t7 != 0)
        goto LAB2;

LAB4:    t7 = (t3 == (unsigned char)1);
    if (t7 != 0)
        goto LAB6;

LAB7:    t7 = (t3 == (unsigned char)2);
    if (t7 != 0)
        goto LAB9;

LAB10:    t7 = (t3 == (unsigned char)3);
    if (t7 != 0)
        goto LAB12;

LAB13:    t8 = (t1 + 6478);
    t0 = xsi_get_transient_memory(5U);
    memcpy(t0, t8, 5U);
    t10 = (t2 + 0U);
    t13 = (t10 + 0U);
    *((int *)t13) = 1;
    t13 = (t10 + 4U);
    *((int *)t13) = 5;
    t13 = (t10 + 8U);
    *((int *)t13) = 1;
    t11 = (5 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t13 = (t10 + 12U);
    *((unsigned int *)t13) = t12;

LAB1:    return t0;
LAB2:    t8 = (t1 + 1648U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(5U);
    memcpy(t0, t9, 5U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 4;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 4);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB3:    xsi_error(ng1);
    t0 = 0;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    t8 = (t1 + 1768U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(5U);
    memcpy(t0, t9, 5U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 4;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 4);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB8:    goto LAB3;

LAB9:    t8 = (t1 + 1888U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(5U);
    memcpy(t0, t9, 5U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 4;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 4);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB11:    goto LAB3;

LAB12:    t8 = (t1 + 2008U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(5U);
    memcpy(t0, t9, 5U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 4;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 4);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB14:    goto LAB3;

LAB15:    goto LAB3;

}

char *ddc4100_p_0656405902_sub_9940356171838605130_981821023(char *t1, char *t2, unsigned char t3)
{
    char t5[8];
    char *t0;
    char *t6;
    unsigned char t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    char *t13;

LAB0:    t6 = (t5 + 4U);
    *((unsigned char *)t6) = t3;
    t7 = (t3 == (unsigned char)0);
    if (t7 != 0)
        goto LAB2;

LAB4:    t7 = (t3 == (unsigned char)1);
    if (t7 != 0)
        goto LAB6;

LAB7:    t7 = (t3 == (unsigned char)2);
    if (t7 != 0)
        goto LAB9;

LAB10:    t7 = (t3 == (unsigned char)3);
    if (t7 != 0)
        goto LAB12;

LAB13:    t8 = (t1 + 6483);
    t0 = xsi_get_transient_memory(11U);
    memcpy(t0, t8, 11U);
    t10 = (t2 + 0U);
    t13 = (t10 + 0U);
    *((int *)t13) = 1;
    t13 = (t10 + 4U);
    *((int *)t13) = 11;
    t13 = (t10 + 8U);
    *((int *)t13) = 1;
    t11 = (11 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t13 = (t10 + 12U);
    *((unsigned int *)t13) = t12;

LAB1:    return t0;
LAB2:    t8 = (t1 + 2128U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(11U);
    memcpy(t0, t9, 11U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 10;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 10);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB3:    xsi_error(ng2);
    t0 = 0;
    goto LAB1;

LAB5:    goto LAB3;

LAB6:    t8 = (t1 + 2248U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(11U);
    memcpy(t0, t9, 11U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 10;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 10);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB8:    goto LAB3;

LAB9:    t8 = (t1 + 2368U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(11U);
    memcpy(t0, t9, 11U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 10;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 10);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB11:    goto LAB3;

LAB12:    t8 = (t1 + 2488U);
    t9 = *((char **)t8);
    t0 = xsi_get_transient_memory(11U);
    memcpy(t0, t9, 11U);
    t8 = (t2 + 0U);
    t10 = (t8 + 0U);
    *((int *)t10) = 10;
    t10 = (t8 + 4U);
    *((int *)t10) = 0;
    t10 = (t8 + 8U);
    *((int *)t10) = -1;
    t11 = (0 - 10);
    t12 = (t11 * -1);
    t12 = (t12 + 1);
    t10 = (t8 + 12U);
    *((unsigned int *)t10) = t12;
    goto LAB1;

LAB14:    goto LAB3;

LAB15:    goto LAB3;

}


extern void ddc4100_p_0656405902_init()
{
	static char *se[] = {(void *)ddc4100_p_0656405902_sub_17828511227308977621_981821023,(void *)ddc4100_p_0656405902_sub_9916005613022380456_981821023,(void *)ddc4100_p_0656405902_sub_9940356171838605130_981821023};
	xsi_register_didat("ddc4100_p_0656405902", "isim/appsfpga_tb_isim_beh.exe.sim/ddc4100/p_0656405902.didat");
	xsi_register_subprogram_executes(se);
}
