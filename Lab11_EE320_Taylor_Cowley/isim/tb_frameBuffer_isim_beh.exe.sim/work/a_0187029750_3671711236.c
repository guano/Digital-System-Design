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
static const char *ng0 = "//fs-caedm/tcowley0/EE 320/Lab11_EE320_Taylor_Cowley/tb_frameBuffer.vhd";
extern char *IEEE_P_2592010699;
extern char *STD_TEXTIO;

unsigned char ieee_p_2592010699_sub_1690584930_503743352(char *, unsigned char );


static void work_a_0187029750_3671711236_p_0(char *t0)
{
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;

LAB0:    xsi_set_current_line(43, ng0);

LAB3:    t1 = (t0 + 4448U);
    t2 = *((char **)t1);
    t3 = *((int64 *)t2);
    t1 = (t0 + 2312U);
    t4 = *((char **)t1);
    t5 = *((unsigned char *)t4);
    t6 = ieee_p_2592010699_sub_1690584930_503743352(IEEE_P_2592010699, t5);
    t1 = (t0 + 6552);
    t7 = (t1 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = t6;
    xsi_driver_first_trans_delta(t1, 0U, 1, t3);
    t11 = (t0 + 6552);
    xsi_driver_intertial_reject(t11, t3, t3);

LAB2:    t12 = (t0 + 6440);
    *((int *)t12) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0187029750_3671711236_p_1(char *t0)
{
    char t10[16];
    char *t1;
    char *t2;
    int64 t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    int t11;
    unsigned int t12;
    unsigned char t13;
    unsigned char t14;
    unsigned char t15;
    unsigned char t16;

LAB0:    t1 = (t0 + 5872U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(53, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 5680);
    xsi_process_wait(t2, t3);

LAB6:    *((char **)t1) = &&LAB7;

LAB1:    return;
LAB4:    xsi_set_current_line(55, ng0);
    t2 = (t0 + 6616);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(56, ng0);
    t2 = xsi_get_transient_memory(5U);
    memset(t2, 0, 5U);
    t4 = t2;
    memset(t4, (unsigned char)2, 5U);
    t5 = (t0 + 6680);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 5U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 5680);
    t4 = (t0 + 4968U);
    t5 = (t0 + 11656);
    t7 = (t10 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 1;
    t8 = (t7 + 4U);
    *((int *)t8) = 28;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t11 = (28 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t12;
    std_textio_write7(STD_TEXTIO, t2, t4, t5, t10, (unsigned char)0, 0);
    xsi_set_current_line(58, ng0);
    t2 = (t0 + 5680);
    t4 = ((STD_TEXTIO) + 1480U);
    t5 = (t0 + 4968U);
    std_textio_writeline(STD_TEXTIO, t2, t4, t5);
    xsi_set_current_line(60, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 5680);
    xsi_process_wait(t2, t3);

LAB10:    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB5:    goto LAB4;

LAB7:    goto LAB5;

LAB8:    xsi_set_current_line(62, ng0);
    t2 = (t0 + 6616);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t2);
    xsi_set_current_line(63, ng0);
    t3 = (100 * 1000LL);
    t2 = (t0 + 5680);
    xsi_process_wait(t2, t3);

LAB14:    *((char **)t1) = &&LAB15;
    goto LAB1;

LAB9:    goto LAB8;

LAB11:    goto LAB9;

LAB12:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 5680);
    t4 = (t0 + 4968U);
    t5 = (t0 + 11684);
    t7 = (t10 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 1;
    t8 = (t7 + 4U);
    *((int *)t8) = 51;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t11 = (51 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t12;
    std_textio_write7(STD_TEXTIO, t2, t4, t5, t10, (unsigned char)0, 0);
    xsi_set_current_line(66, ng0);
    t2 = (t0 + 5680);
    t4 = ((STD_TEXTIO) + 1480U);
    t5 = (t0 + 4968U);
    std_textio_writeline(STD_TEXTIO, t2, t4, t5);
    xsi_set_current_line(68, ng0);

LAB18:    t2 = (t0 + 6456);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB19;
    goto LAB1;

LAB13:    goto LAB12;

LAB15:    goto LAB13;

LAB16:    t5 = (t0 + 6456);
    *((int *)t5) = 0;
    xsi_set_current_line(70, ng0);
    t2 = (t0 + 5680);
    t4 = (t0 + 4968U);
    t5 = (t0 + 11735);
    t7 = (t10 + 0U);
    t8 = (t7 + 0U);
    *((int *)t8) = 1;
    t8 = (t7 + 4U);
    *((int *)t8) = 51;
    t8 = (t7 + 8U);
    *((int *)t8) = 1;
    t11 = (51 - 1);
    t12 = (t11 * 1);
    t12 = (t12 + 1);
    t8 = (t7 + 12U);
    *((unsigned int *)t8) = t12;
    std_textio_write7(STD_TEXTIO, t2, t4, t5, t10, (unsigned char)0, 0);
    xsi_set_current_line(71, ng0);
    t2 = (t0 + 5680);
    t4 = (t0 + 4968U);
    t3 = xsi_get_sim_current_time();
    std_textio_write8(STD_TEXTIO, t2, t4, t3, (unsigned char)0, 0, 1000LL);
    xsi_set_current_line(72, ng0);
    t2 = (t0 + 5680);
    t4 = ((STD_TEXTIO) + 1480U);
    t5 = (t0 + 4968U);
    std_textio_writeline(STD_TEXTIO, t2, t4, t5);
    xsi_set_current_line(73, ng0);
    t2 = (t0 + 11786);
    t5 = (t0 + 6680);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t2, 5U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(76, ng0);

LAB25:    *((char **)t1) = &&LAB26;
    goto LAB1;

LAB17:    t4 = (t0 + 2592U);
    t14 = xsi_signal_has_event(t4);
    if (t14 == 1)
        goto LAB20;

LAB21:    t13 = (unsigned char)0;

LAB22:    if (t13 == 1)
        goto LAB16;
    else
        goto LAB18;

LAB19:    goto LAB17;

LAB20:    t5 = (t0 + 2632U);
    t6 = *((char **)t5);
    t15 = *((unsigned char *)t6);
    t16 = (t15 == (unsigned char)2);
    t13 = t16;
    goto LAB22;

LAB23:    goto LAB2;

LAB24:    goto LAB23;

LAB26:    goto LAB24;

}

static void work_a_0187029750_3671711236_p_2(char *t0)
{
    char t4[16];
    char t10[16];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned char t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(80, ng0);

LAB3:    t1 = (t0 + 3112U);
    t2 = *((char **)t1);
    t1 = (t0 + 3272U);
    t3 = *((char **)t1);
    t5 = ((IEEE_P_2592010699) + 4024);
    t6 = (t0 + 11360U);
    t7 = (t0 + 11360U);
    t1 = xsi_base_array_concat(t1, t4, t5, (char)97, t2, t6, (char)97, t3, t7, (char)101);
    t8 = (t0 + 3432U);
    t9 = *((char **)t8);
    t11 = ((IEEE_P_2592010699) + 4024);
    t12 = (t0 + 11376U);
    t8 = xsi_base_array_concat(t8, t10, t11, (char)97, t1, t4, (char)97, t9, t12, (char)101);
    t13 = (3U + 3U);
    t14 = (t13 + 2U);
    t15 = (8U != t14);
    if (t15 == 1)
        goto LAB5;

LAB6:    t16 = (t0 + 6744);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t8, 8U);
    xsi_driver_first_trans_fast(t16);

LAB2:    t21 = (t0 + 6472);
    *((int *)t21) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(8U, t14, 0);
    goto LAB6;

}


extern void work_a_0187029750_3671711236_init()
{
	static char *pe[] = {(void *)work_a_0187029750_3671711236_p_0,(void *)work_a_0187029750_3671711236_p_1,(void *)work_a_0187029750_3671711236_p_2};
	xsi_register_didat("work_a_0187029750_3671711236", "isim/tb_frameBuffer_isim_beh.exe.sim/work/a_0187029750_3671711236.didat");
	xsi_register_executes(pe);
}
