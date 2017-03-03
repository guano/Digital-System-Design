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
static const char *ng0 = "//fs-caedm/tcowley0/EE 320/Lab4_EE320_Taylor_Cowley/seven_seg_control.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1919365254_1035706684(char *, char *, char *, char *, int );
unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );


static void work_a_0200821880_0053165572_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    char *t12;
    char *t13;
    int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned char t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    t1 = (t0 + 3752U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(43, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 10042);
    t5 = xsi_mem_cmp(t2, t3, 2U);
    if (t5 == 1)
        goto LAB5;

LAB9:    t6 = (t0 + 10044);
    t8 = xsi_mem_cmp(t6, t3, 2U);
    if (t8 == 1)
        goto LAB6;

LAB10:    t9 = (t0 + 10046);
    t11 = xsi_mem_cmp(t9, t3, 2U);
    if (t11 == 1)
        goto LAB7;

LAB11:
LAB8:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t5 = (3 - 3);
    t15 = (t5 * -1);
    t16 = (1U * t15);
    t17 = (0 + t16);
    t2 = (t3 + t17);
    t18 = *((unsigned char *)t2);
    t19 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t18);
    t4 = (t0 + 6264);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t19;
    xsi_driver_first_trans_fast_port(t4);

LAB4:    xsi_set_current_line(43, ng0);

LAB15:    t2 = (t0 + 6056);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB16;

LAB1:    return;
LAB5:    xsi_set_current_line(44, ng0);
    t12 = (t0 + 1352U);
    t13 = *((char **)t12);
    t14 = (0 - 3);
    t15 = (t14 * -1);
    t16 = (1U * t15);
    t17 = (0 + t16);
    t12 = (t13 + t17);
    t18 = *((unsigned char *)t12);
    t19 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t18);
    t20 = (t0 + 6264);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    *((unsigned char *)t24) = t19;
    xsi_driver_first_trans_fast_port(t20);
    goto LAB4;

LAB6:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t5 = (1 - 3);
    t15 = (t5 * -1);
    t16 = (1U * t15);
    t17 = (0 + t16);
    t2 = (t3 + t17);
    t18 = *((unsigned char *)t2);
    t19 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t18);
    t4 = (t0 + 6264);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t19;
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB7:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 1352U);
    t3 = *((char **)t2);
    t5 = (2 - 3);
    t15 = (t5 * -1);
    t16 = (1U * t15);
    t17 = (0 + t16);
    t2 = (t3 + t17);
    t18 = *((unsigned char *)t2);
    t19 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t18);
    t4 = (t0 + 6264);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t19;
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB12:;
LAB13:    t3 = (t0 + 6056);
    *((int *)t3) = 0;
    goto LAB2;

LAB14:    goto LAB13;

LAB16:    goto LAB14;

}

static void work_a_0200821880_0053165572_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    char *t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;

LAB0:    t1 = (t0 + 4000U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(50, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 10048);
    t5 = xsi_mem_cmp(t2, t3, 2U);
    if (t5 == 1)
        goto LAB5;

LAB9:    t6 = (t0 + 10050);
    t8 = xsi_mem_cmp(t6, t3, 2U);
    if (t8 == 1)
        goto LAB6;

LAB10:    t9 = (t0 + 10052);
    t11 = xsi_mem_cmp(t9, t3, 2U);
    if (t11 == 1)
        goto LAB7;

LAB11:
LAB8:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t14 = (15 - 15);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t2 = (t3 + t16);
    t4 = (t0 + 6328);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 4U);
    xsi_driver_first_trans_fast(t4);

LAB4:    xsi_set_current_line(50, ng0);

LAB15:    t2 = (t0 + 6072);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB16;

LAB1:    return;
LAB5:    xsi_set_current_line(51, ng0);
    t12 = (t0 + 1192U);
    t13 = *((char **)t12);
    t14 = (15 - 3);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t12 = (t13 + t16);
    t17 = (t0 + 6328);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t12, 4U);
    xsi_driver_first_trans_fast(t17);
    goto LAB4;

LAB6:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t14 = (15 - 7);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t2 = (t3 + t16);
    t4 = (t0 + 6328);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 4U);
    xsi_driver_first_trans_fast(t4);
    goto LAB4;

LAB7:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1192U);
    t3 = *((char **)t2);
    t14 = (15 - 11);
    t15 = (t14 * 1U);
    t16 = (0 + t15);
    t2 = (t3 + t16);
    t4 = (t0 + 6328);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 4U);
    xsi_driver_first_trans_fast(t4);
    goto LAB4;

LAB12:;
LAB13:    t3 = (t0 + 6072);
    *((int *)t3) = 0;
    goto LAB2;

LAB14:    goto LAB13;

LAB16:    goto LAB14;

}

static void work_a_0200821880_0053165572_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    char *t12;
    int t14;
    char *t15;
    int t17;
    char *t18;
    int t20;
    char *t21;
    int t23;
    char *t24;
    int t26;
    char *t27;
    int t29;
    char *t30;
    int t32;
    char *t33;
    int t35;
    char *t36;
    int t38;
    char *t39;
    int t41;
    char *t42;
    int t44;
    char *t45;
    int t47;
    char *t48;
    int t50;
    char *t51;
    char *t53;
    char *t54;
    char *t55;
    char *t56;
    char *t57;

LAB0:    t1 = (t0 + 4248U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(57, ng0);
    t2 = (t0 + 2312U);
    t3 = *((char **)t2);
    t2 = (t0 + 10054);
    t5 = xsi_mem_cmp(t2, t3, 4U);
    if (t5 == 1)
        goto LAB5;

LAB22:    t6 = (t0 + 10058);
    t8 = xsi_mem_cmp(t6, t3, 4U);
    if (t8 == 1)
        goto LAB6;

LAB23:    t9 = (t0 + 10062);
    t11 = xsi_mem_cmp(t9, t3, 4U);
    if (t11 == 1)
        goto LAB7;

LAB24:    t12 = (t0 + 10066);
    t14 = xsi_mem_cmp(t12, t3, 4U);
    if (t14 == 1)
        goto LAB8;

LAB25:    t15 = (t0 + 10070);
    t17 = xsi_mem_cmp(t15, t3, 4U);
    if (t17 == 1)
        goto LAB9;

LAB26:    t18 = (t0 + 10074);
    t20 = xsi_mem_cmp(t18, t3, 4U);
    if (t20 == 1)
        goto LAB10;

LAB27:    t21 = (t0 + 10078);
    t23 = xsi_mem_cmp(t21, t3, 4U);
    if (t23 == 1)
        goto LAB11;

LAB28:    t24 = (t0 + 10082);
    t26 = xsi_mem_cmp(t24, t3, 4U);
    if (t26 == 1)
        goto LAB12;

LAB29:    t27 = (t0 + 10086);
    t29 = xsi_mem_cmp(t27, t3, 4U);
    if (t29 == 1)
        goto LAB13;

LAB30:    t30 = (t0 + 10090);
    t32 = xsi_mem_cmp(t30, t3, 4U);
    if (t32 == 1)
        goto LAB14;

LAB31:    t33 = (t0 + 10094);
    t35 = xsi_mem_cmp(t33, t3, 4U);
    if (t35 == 1)
        goto LAB15;

LAB32:    t36 = (t0 + 10098);
    t38 = xsi_mem_cmp(t36, t3, 4U);
    if (t38 == 1)
        goto LAB16;

LAB33:    t39 = (t0 + 10102);
    t41 = xsi_mem_cmp(t39, t3, 4U);
    if (t41 == 1)
        goto LAB17;

LAB34:    t42 = (t0 + 10106);
    t44 = xsi_mem_cmp(t42, t3, 4U);
    if (t44 == 1)
        goto LAB18;

LAB35:    t45 = (t0 + 10110);
    t47 = xsi_mem_cmp(t45, t3, 4U);
    if (t47 == 1)
        goto LAB19;

LAB36:    t48 = (t0 + 10114);
    t50 = xsi_mem_cmp(t48, t3, 4U);
    if (t50 == 1)
        goto LAB20;

LAB37:
LAB21:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10230);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);

LAB4:    xsi_set_current_line(57, ng0);

LAB41:    t2 = (t0 + 6088);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB42;

LAB1:    return;
LAB5:    xsi_set_current_line(58, ng0);
    t51 = (t0 + 10118);
    t53 = (t0 + 6392);
    t54 = (t53 + 56U);
    t55 = *((char **)t54);
    t56 = (t55 + 56U);
    t57 = *((char **)t56);
    memcpy(t57, t51, 7U);
    xsi_driver_first_trans_fast_port(t53);
    goto LAB4;

LAB6:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10125);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB7:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10132);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB8:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10139);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB9:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10146);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB10:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10153);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB11:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10160);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB12:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10167);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB13:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10174);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB14:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10181);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB15:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10188);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB16:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10195);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB17:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10202);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB18:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10209);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB19:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10216);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB20:    xsi_set_current_line(58, ng0);
    t2 = (t0 + 10223);
    t4 = (t0 + 6392);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 7U);
    xsi_driver_first_trans_fast_port(t4);
    goto LAB4;

LAB38:;
LAB39:    t3 = (t0 + 6088);
    *((int *)t3) = 0;
    goto LAB2;

LAB40:    goto LAB39;

LAB42:    goto LAB40;

}

static void work_a_0200821880_0053165572_p_3(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t5;
    unsigned int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(79, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 10237);
    t5 = 1;
    if (2U == 2U)
        goto LAB8;

LAB9:    t5 = 0;

LAB10:    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t22 = (t0 + 6456);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = (unsigned char)3;
    xsi_driver_first_trans_delta(t22, 3U, 1, 0LL);

LAB2:    t27 = (t0 + 6104);
    *((int *)t27) = 1;

LAB1:    return;
LAB3:    t17 = (t0 + 6456);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((unsigned char *)t21) = (unsigned char)2;
    xsi_driver_first_trans_delta(t17, 3U, 1, 0LL);
    goto LAB2;

LAB5:    t9 = (t0 + 1512U);
    t10 = *((char **)t9);
    t11 = (0 - 3);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t9 = (t10 + t14);
    t15 = *((unsigned char *)t9);
    t16 = (t15 == (unsigned char)2);
    t1 = t16;
    goto LAB7;

LAB8:    t6 = 0;

LAB11:    if (t6 < 2U)
        goto LAB12;
    else
        goto LAB10;

LAB12:    t7 = (t3 + t6);
    t8 = (t2 + t6);
    if (*((unsigned char *)t7) != *((unsigned char *)t8))
        goto LAB9;

LAB13:    t6 = (t6 + 1);
    goto LAB11;

LAB15:    goto LAB2;

}

static void work_a_0200821880_0053165572_p_4(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t5;
    unsigned int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(80, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 10239);
    t5 = 1;
    if (2U == 2U)
        goto LAB8;

LAB9:    t5 = 0;

LAB10:    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t22 = (t0 + 6520);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = (unsigned char)3;
    xsi_driver_first_trans_delta(t22, 2U, 1, 0LL);

LAB2:    t27 = (t0 + 6120);
    *((int *)t27) = 1;

LAB1:    return;
LAB3:    t17 = (t0 + 6520);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((unsigned char *)t21) = (unsigned char)2;
    xsi_driver_first_trans_delta(t17, 2U, 1, 0LL);
    goto LAB2;

LAB5:    t9 = (t0 + 1512U);
    t10 = *((char **)t9);
    t11 = (1 - 3);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t9 = (t10 + t14);
    t15 = *((unsigned char *)t9);
    t16 = (t15 == (unsigned char)2);
    t1 = t16;
    goto LAB7;

LAB8:    t6 = 0;

LAB11:    if (t6 < 2U)
        goto LAB12;
    else
        goto LAB10;

LAB12:    t7 = (t3 + t6);
    t8 = (t2 + t6);
    if (*((unsigned char *)t7) != *((unsigned char *)t8))
        goto LAB9;

LAB13:    t6 = (t6 + 1);
    goto LAB11;

LAB15:    goto LAB2;

}

static void work_a_0200821880_0053165572_p_5(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t5;
    unsigned int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(81, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 10241);
    t5 = 1;
    if (2U == 2U)
        goto LAB8;

LAB9:    t5 = 0;

LAB10:    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t22 = (t0 + 6584);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = (unsigned char)3;
    xsi_driver_first_trans_delta(t22, 1U, 1, 0LL);

LAB2:    t27 = (t0 + 6136);
    *((int *)t27) = 1;

LAB1:    return;
LAB3:    t17 = (t0 + 6584);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((unsigned char *)t21) = (unsigned char)2;
    xsi_driver_first_trans_delta(t17, 1U, 1, 0LL);
    goto LAB2;

LAB5:    t9 = (t0 + 1512U);
    t10 = *((char **)t9);
    t11 = (2 - 3);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t9 = (t10 + t14);
    t15 = *((unsigned char *)t9);
    t16 = (t15 == (unsigned char)2);
    t1 = t16;
    goto LAB7;

LAB8:    t6 = 0;

LAB11:    if (t6 < 2U)
        goto LAB12;
    else
        goto LAB10;

LAB12:    t7 = (t3 + t6);
    t8 = (t2 + t6);
    if (*((unsigned char *)t7) != *((unsigned char *)t8))
        goto LAB9;

LAB13:    t6 = (t6 + 1);
    goto LAB11;

LAB15:    goto LAB2;

}

static void work_a_0200821880_0053165572_p_6(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t5;
    unsigned int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;
    char *t27;

LAB0:    xsi_set_current_line(82, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t2 = (t0 + 10243);
    t5 = 1;
    if (2U == 2U)
        goto LAB8;

LAB9:    t5 = 0;

LAB10:    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB3;

LAB4:
LAB14:    t22 = (t0 + 6648);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    *((unsigned char *)t26) = (unsigned char)3;
    xsi_driver_first_trans_delta(t22, 0U, 1, 0LL);

LAB2:    t27 = (t0 + 6152);
    *((int *)t27) = 1;

LAB1:    return;
LAB3:    t17 = (t0 + 6648);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    *((unsigned char *)t21) = (unsigned char)2;
    xsi_driver_first_trans_delta(t17, 0U, 1, 0LL);
    goto LAB2;

LAB5:    t9 = (t0 + 1512U);
    t10 = *((char **)t9);
    t11 = (3 - 3);
    t12 = (t11 * -1);
    t13 = (1U * t12);
    t14 = (0 + t13);
    t9 = (t10 + t14);
    t15 = *((unsigned char *)t9);
    t16 = (t15 == (unsigned char)2);
    t1 = t16;
    goto LAB7;

LAB8:    t6 = 0;

LAB11:    if (t6 < 2U)
        goto LAB12;
    else
        goto LAB10;

LAB12:    t7 = (t3 + t6);
    t8 = (t2 + t6);
    if (*((unsigned char *)t7) != *((unsigned char *)t8))
        goto LAB9;

LAB13:    t6 = (t6 + 1);
    goto LAB11;

LAB15:    goto LAB2;

}

static void work_a_0200821880_0053165572_p_7(char *t0)
{
    char t8[16];
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

LAB0:    xsi_set_current_line(87, ng0);
    t2 = (t0 + 992U);
    t3 = xsi_signal_has_event(t2);
    if (t3 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 6168);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(88, ng0);
    t4 = (t0 + 2472U);
    t9 = *((char **)t4);
    t4 = (t0 + 9968U);
    t10 = ieee_p_1242562249_sub_1919365254_1035706684(IEEE_P_1242562249, t8, t9, t4, 1);
    t11 = (t8 + 12U);
    t12 = *((unsigned int *)t11);
    t13 = (1U * t12);
    t14 = (15U != t13);
    if (t14 == 1)
        goto LAB8;

LAB9:    t15 = (t0 + 6712);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memcpy(t19, t10, 15U);
    xsi_driver_first_trans_fast(t15);
    goto LAB3;

LAB5:    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)3);
    t1 = t7;
    goto LAB7;

LAB8:    xsi_size_not_matching(15U, t13, 0);
    goto LAB9;

}

static void work_a_0200821880_0053165572_p_8(char *t0)
{
    char *t1;
    char *t2;
    int t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    xsi_set_current_line(92, ng0);

LAB3:    t1 = (t0 + 2472U);
    t2 = *((char **)t1);
    t3 = (15 - 1);
    t4 = (14 - t3);
    t5 = (t4 * 1U);
    t6 = (0 + t5);
    t1 = (t2 + t6);
    t7 = (t0 + 6776);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 2U);
    xsi_driver_first_trans_fast(t7);

LAB2:    t12 = (t0 + 6184);
    *((int *)t12) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0200821880_0053165572_init()
{
	static char *pe[] = {(void *)work_a_0200821880_0053165572_p_0,(void *)work_a_0200821880_0053165572_p_1,(void *)work_a_0200821880_0053165572_p_2,(void *)work_a_0200821880_0053165572_p_3,(void *)work_a_0200821880_0053165572_p_4,(void *)work_a_0200821880_0053165572_p_5,(void *)work_a_0200821880_0053165572_p_6,(void *)work_a_0200821880_0053165572_p_7,(void *)work_a_0200821880_0053165572_p_8};
	xsi_register_didat("work_a_0200821880_0053165572", "isim/seven_segment_top_isim_beh.exe.sim/work/a_0200821880_0053165572.didat");
	xsi_register_executes(pe);
}
