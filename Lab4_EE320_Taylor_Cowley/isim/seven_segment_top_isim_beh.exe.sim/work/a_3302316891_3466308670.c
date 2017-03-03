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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//fs-caedm/tcowley0/EE 320/Lab4_EE320_Taylor_Cowley/seven_segment_top.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );


static void work_a_3302316891_3466308670_p_0(char *t0)
{
    char t8[16];
    char t26[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t9;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    int t20;
    unsigned int t21;
    int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    char *t27;
    char *t28;
    char *t29;

LAB0:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t20 = (3 - 3);
    t12 = (t20 * -1);
    t13 = (1U * t12);
    t21 = (0 + t13);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB10;

LAB12:    t5 = (t0 + 1192U);
    t9 = *((char **)t5);
    t22 = (2 - 3);
    t23 = (t22 * -1);
    t24 = (1U * t23);
    t25 = (0 + t24);
    t5 = (t9 + t25);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    if (t7 != 0)
        goto LAB13;

LAB14:    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t20 = (1 - 3);
    t12 = (t20 * -1);
    t13 = (1U * t12);
    t21 = (0 + t13);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB15;

LAB16:    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t20 = (0 - 3);
    t12 = (t20 * -1);
    t13 = (1U * t12);
    t21 = (0 + t13);
    t2 = (t4 + t21);
    t1 = *((unsigned char *)t2);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB19;

LAB20:    xsi_set_current_line(78, ng0);
    t2 = (t0 + 2472U);
    t4 = *((char **)t2);
    t12 = (31 - 31);
    t13 = (t12 * 1U);
    t21 = (0 + t13);
    t2 = (t4 + t21);
    t5 = (t0 + 4216);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 16U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(79, ng0);
    t2 = (t0 + 7220);
    t5 = (t0 + 4280);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(80, ng0);
    t2 = (t0 + 7224);
    t5 = (t0 + 4344);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);

LAB11:    t2 = (t0 + 4072);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(54, ng0);
    t4 = (t0 + 2472U);
    t9 = *((char **)t4);
    t4 = (t0 + 7072U);
    t10 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t8, t9, t4, 1);
    t11 = (t8 + 12U);
    t12 = *((unsigned int *)t11);
    t13 = (1U * t12);
    t14 = (32U != t13);
    if (t14 == 1)
        goto LAB8;

LAB9:    t15 = (t0 + 4152);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t10, 32U);
    xsi_driver_first_trans_fast(t15);
    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_size_not_matching(32U, t13, 0);
    goto LAB9;

LAB10:    goto LAB11;

LAB13:    xsi_set_current_line(61, ng0);
    t10 = (t0 + 7172);
    t15 = (t0 + 4216);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t10, 16U);
    xsi_driver_first_trans_fast(t15);
    xsi_set_current_line(62, ng0);
    t2 = (t0 + 7188);
    t5 = (t0 + 4280);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(63, ng0);
    t2 = (t0 + 7192);
    t5 = (t0 + 4344);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    goto LAB11;

LAB15:    xsi_set_current_line(66, ng0);
    t5 = (t0 + 7196);
    t10 = (t0 + 1352U);
    t11 = *((char **)t10);
    t15 = ((IEEE_P_2592010699) + 4024);
    t16 = (t26 + 0U);
    t17 = (t16 + 0U);
    *((int *)t17) = 0;
    t17 = (t16 + 4U);
    *((int *)t17) = 7;
    t17 = (t16 + 8U);
    *((int *)t17) = 1;
    t22 = (7 - 0);
    t23 = (t22 * 1);
    t23 = (t23 + 1);
    t17 = (t16 + 12U);
    *((unsigned int *)t17) = t23;
    t17 = (t0 + 6976U);
    t10 = xsi_base_array_concat(t10, t8, t15, (char)97, t5, t26, (char)97, t11, t17, (char)101);
    t23 = (8U + 8U);
    t6 = (16U != t23);
    if (t6 == 1)
        goto LAB17;

LAB18:    t18 = (t0 + 4216);
    t19 = (t18 + 56U);
    t27 = *((char **)t19);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t10, 16U);
    xsi_driver_first_trans_fast(t18);
    xsi_set_current_line(67, ng0);
    t2 = (t0 + 7204);
    t5 = (t0 + 4280);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 7208);
    t5 = (t0 + 4344);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    goto LAB11;

LAB17:    xsi_size_not_matching(16U, t23, 0);
    goto LAB18;

LAB19:    xsi_set_current_line(72, ng0);
    t5 = (t0 + 2472U);
    t9 = *((char **)t5);
    t23 = (31 - 15);
    t24 = (t23 * 1U);
    t25 = (0 + t24);
    t5 = (t9 + t25);
    t10 = (t0 + 4216);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t5, 16U);
    xsi_driver_first_trans_fast(t10);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 7212);
    t5 = (t0 + 4280);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(74, ng0);
    t2 = (t0 + 7216);
    t5 = (t0 + 4344);
    t9 = (t5 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t15 = *((char **)t11);
    memcpy(t15, t2, 4U);
    xsi_driver_first_trans_fast(t5);
    goto LAB11;

}


extern void work_a_3302316891_3466308670_init()
{
	static char *pe[] = {(void *)work_a_3302316891_3466308670_p_0};
	xsi_register_didat("work_a_3302316891_3466308670", "isim/seven_segment_top_isim_beh.exe.sim/work/a_3302316891_3466308670.didat");
	xsi_register_executes(pe);
}
