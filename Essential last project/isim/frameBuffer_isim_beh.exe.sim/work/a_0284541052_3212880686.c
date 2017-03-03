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
static const char *ng0 = "//fs-caedm/tcowley0/EE 320/Essential last project/vga_timing.vhd";
extern char *IEEE_P_1242562249;
extern char *IEEE_P_2592010699;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_1242562249_sub_2110375371_1035706684(char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_2545490612_503743352(char *, unsigned char , unsigned char );


static void work_a_0284541052_3212880686_p_0(char *t0)
{
    char t15[16];
    unsigned char t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    int t16;
    unsigned int t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;

LAB0:    xsi_set_current_line(26, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 1192U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB41;

LAB43:
LAB42:    t2 = (t0 + 5336);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(27, ng0);
    t4 = (t0 + 2472U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)2);
    if (t10 != 0)
        goto LAB8;

LAB10:    t2 = (t0 + 2472U);
    t4 = *((char **)t2);
    t1 = *((unsigned char *)t4);
    t3 = (t1 == (unsigned char)3);
    if (t3 != 0)
        goto LAB11;

LAB12:
LAB9:    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_set_current_line(28, ng0);
    t4 = (t0 + 5464);
    t11 = (t4 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = (unsigned char)3;
    xsi_driver_first_trans_fast(t4);
    goto LAB9;

LAB11:    xsi_set_current_line(30, ng0);
    t2 = (t0 + 5464);
    t5 = (t2 + 56U);
    t8 = *((char **)t5);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    *((unsigned char *)t12) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(34, ng0);
    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t2 = (t0 + 9040U);
    t5 = (t0 + 9105);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB13;

LAB15:    xsi_set_current_line(63, ng0);
    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t2 = (t0 + 9040U);
    t5 = (t0 + 9185);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB30;

LAB32:    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t2 = (t0 + 9040U);
    t5 = (t0 + 9195);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB33;

LAB34:    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t2 = (t0 + 9040U);
    t5 = (t0 + 9205);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB35;

LAB36:    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t2 = (t0 + 9040U);
    t5 = (t0 + 9215);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB37;

LAB38:
LAB31:    xsi_set_current_line(79, ng0);
    t2 = (t0 + 2632U);
    t4 = *((char **)t2);
    t2 = (t0 + 9040U);
    t5 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t15, t4, t2, 1);
    t8 = (t15 + 12U);
    t17 = *((unsigned int *)t8);
    t22 = (1U * t17);
    t1 = (10U != t22);
    if (t1 == 1)
        goto LAB39;

LAB40:    t11 = (t0 + 5528);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t5, 10U);
    xsi_driver_first_trans_fast(t11);

LAB14:    goto LAB9;

LAB13:    xsi_set_current_line(35, ng0);
    t12 = (t0 + 9115);
    t14 = (t0 + 5528);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t12, 10U);
    xsi_driver_first_trans_fast(t14);
    xsi_set_current_line(36, ng0);
    t2 = (t0 + 5592);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(40, ng0);
    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 9056U);
    t5 = (t0 + 9125);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB16;

LAB18:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 9056U);
    t5 = (t0 + 9145);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB19;

LAB21:    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 9056U);
    t5 = (t0 + 9155);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB22;

LAB23:    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 9056U);
    t5 = (t0 + 9165);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB24;

LAB25:    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 9056U);
    t5 = (t0 + 9175);
    t11 = (t15 + 0U);
    t12 = (t11 + 0U);
    *((int *)t12) = 0;
    t12 = (t11 + 4U);
    *((int *)t12) = 9;
    t12 = (t11 + 8U);
    *((int *)t12) = 1;
    t16 = (9 - 0);
    t17 = (t16 * 1);
    t17 = (t17 + 1);
    t12 = (t11 + 12U);
    *((unsigned int *)t12) = t17;
    t1 = ieee_p_1242562249_sub_2110375371_1035706684(IEEE_P_1242562249, t4, t2, t5, t15);
    if (t1 != 0)
        goto LAB26;

LAB27:
LAB20:    xsi_set_current_line(59, ng0);
    t2 = (t0 + 2792U);
    t4 = *((char **)t2);
    t2 = (t0 + 9056U);
    t5 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t15, t4, t2, 1);
    t8 = (t15 + 12U);
    t17 = *((unsigned int *)t8);
    t22 = (1U * t17);
    t1 = (10U != t22);
    if (t1 == 1)
        goto LAB28;

LAB29:    t11 = (t0 + 5656);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t14 = (t13 + 56U);
    t18 = *((char **)t14);
    memcpy(t18, t5, 10U);
    xsi_driver_first_trans_fast(t11);

LAB17:    goto LAB14;

LAB16:    xsi_set_current_line(41, ng0);
    t12 = (t0 + 9135);
    t14 = (t0 + 5656);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t12, 10U);
    xsi_driver_first_trans_fast(t14);
    xsi_set_current_line(42, ng0);
    t2 = (t0 + 5720);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB17;

LAB19:    xsi_set_current_line(45, ng0);
    t12 = (t0 + 5784);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t12);
    goto LAB20;

LAB22:    xsi_set_current_line(47, ng0);
    t12 = (t0 + 5784);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t12);
    xsi_set_current_line(48, ng0);
    t2 = (t0 + 5720);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB20;

LAB24:    xsi_set_current_line(55, ng0);
    t12 = (t0 + 5848);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t12);
    goto LAB20;

LAB26:    xsi_set_current_line(57, ng0);
    t12 = (t0 + 5848);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t12);
    goto LAB20;

LAB28:    xsi_size_not_matching(10U, t22, 0);
    goto LAB29;

LAB30:    xsi_set_current_line(64, ng0);
    t12 = (t0 + 5912);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t12);
    goto LAB31;

LAB33:    xsi_set_current_line(66, ng0);
    t12 = (t0 + 5912);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t12);
    xsi_set_current_line(67, ng0);
    t2 = (t0 + 5592);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    goto LAB31;

LAB35:    xsi_set_current_line(74, ng0);
    t12 = (t0 + 5976);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t12);
    goto LAB31;

LAB37:    xsi_set_current_line(76, ng0);
    t12 = (t0 + 5976);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t18 = (t14 + 56U);
    t19 = *((char **)t18);
    *((unsigned char *)t19) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t12);
    goto LAB31;

LAB39:    xsi_size_not_matching(10U, t22, 0);
    goto LAB40;

LAB41:    xsi_set_current_line(85, ng0);
    t2 = (t0 + 9225);
    t8 = (t0 + 5528);
    t11 = (t8 + 56U);
    t12 = *((char **)t11);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t2, 10U);
    xsi_driver_first_trans_fast(t8);
    xsi_set_current_line(86, ng0);
    t2 = (t0 + 9235);
    t5 = (t0 + 5656);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t2, 10U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(87, ng0);
    t2 = (t0 + 5976);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(88, ng0);
    t2 = (t0 + 5848);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(89, ng0);
    t2 = (t0 + 5912);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 5784);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(91, ng0);
    t2 = (t0 + 5720);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(92, ng0);
    t2 = (t0 + 5592);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 5464);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t8 = (t5 + 56U);
    t11 = *((char **)t8);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    goto LAB42;

}

static void work_a_0284541052_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(97, ng0);

LAB3:    t1 = (t0 + 2632U);
    t2 = *((char **)t1);
    t1 = (t0 + 6040);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 10U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 5352);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0284541052_3212880686_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(98, ng0);

LAB3:    t1 = (t0 + 2792U);
    t2 = *((char **)t1);
    t1 = (t0 + 6104);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 10U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 5368);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0284541052_3212880686_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;

LAB0:    xsi_set_current_line(99, ng0);

LAB3:    t1 = (t0 + 2952U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 3112U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_2545490612_503743352(IEEE_P_2592010699, t3, t5);
    t1 = (t0 + 6168);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t11 = (t0 + 5384);
    *((int *)t11) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0284541052_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0284541052_3212880686_p_0,(void *)work_a_0284541052_3212880686_p_1,(void *)work_a_0284541052_3212880686_p_2,(void *)work_a_0284541052_3212880686_p_3};
	xsi_register_didat("work_a_0284541052_3212880686", "isim/frameBuffer_isim_beh.exe.sim/work/a_0284541052_3212880686.didat");
	xsi_register_executes(pe);
}
