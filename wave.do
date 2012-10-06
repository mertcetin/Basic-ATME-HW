onerror {resume}
quietly WaveActivateNextPane {} 0
quietly virtual signal -install /test3DRS/DUT { /test3DRS/DUT/updatevec[5:3]} update_y
quietly virtual signal -install /test3DRS/DUT { /test3DRS/DUT/updatevec[2:0]} update_x
quietly virtual signal -install /test3DRS/DUT { /test3DRS/DUT/MVout[13:7]} MVouty
quietly virtual signal -install /test3DRS/DUT { /test3DRS/DUT/MVout[6:0]} MVoutx
quietly virtual signal -install /test3DRS/DUT { /test3DRS/DUT/curpos[13:7]} curpos_y
quietly virtual signal -install /test3DRS/DUT { /test3DRS/DUT/curpos[6:0]} curpos_x
quietly virtual signal -install /test3DRS/DUT/swaddrgen { /test3DRS/DUT/swaddrgen/vecin[13:7]} vecin_y
quietly virtual signal -install /test3DRS/DUT/swaddrgen { /test3DRS/DUT/swaddrgen/vecin[6:0]} vecin_x
quietly virtual function -install /test3DRS/DUT/swaddrgen -env /test3DRS/DUT/pe_array/#ASSIGN#598 { &{/test3DRS/DUT/swaddrgen/vectors0[13], /test3DRS/DUT/swaddrgen/vectors0[12], /test3DRS/DUT/swaddrgen/vectors0[11], /test3DRS/DUT/swaddrgen/vectors0[10], /test3DRS/DUT/swaddrgen/vectors0[9], /test3DRS/DUT/swaddrgen/vectors0[8], /test3DRS/DUT/swaddrgen/vectors0[7] }} vectors0_y
quietly virtual function -install /test3DRS/DUT/swaddrgen -env /test3DRS/DUT/pe_array/#ASSIGN#598 { &{/test3DRS/DUT/swaddrgen/vectors0[6], /test3DRS/DUT/swaddrgen/vectors0[5], /test3DRS/DUT/swaddrgen/vectors0[4], /test3DRS/DUT/swaddrgen/vectors0[3], /test3DRS/DUT/swaddrgen/vectors0[2], /test3DRS/DUT/swaddrgen/vectors0[1], /test3DRS/DUT/swaddrgen/vectors0[0] }} vectors0_x
quietly virtual function -install /test3DRS/DUT/swaddrgen -env /test3DRS/DUT/pe_array/#ASSIGN#598 { &{/test3DRS/DUT/swaddrgen/vectors1[13], /test3DRS/DUT/swaddrgen/vectors1[12], /test3DRS/DUT/swaddrgen/vectors1[11], /test3DRS/DUT/swaddrgen/vectors1[10], /test3DRS/DUT/swaddrgen/vectors1[9], /test3DRS/DUT/swaddrgen/vectors1[8], /test3DRS/DUT/swaddrgen/vectors1[7] }} vectors1_y
quietly virtual function -install /test3DRS/DUT/swaddrgen -env /test3DRS/DUT/pe_array/#ASSIGN#598 { &{/test3DRS/DUT/swaddrgen/vectors1[6], /test3DRS/DUT/swaddrgen/vectors1[5], /test3DRS/DUT/swaddrgen/vectors1[4], /test3DRS/DUT/swaddrgen/vectors1[3], /test3DRS/DUT/swaddrgen/vectors1[2], /test3DRS/DUT/swaddrgen/vectors1[1], /test3DRS/DUT/swaddrgen/vectors1[0] }} vectors1_x
quietly virtual function -install /test3DRS/DUT/swaddrgen -env /test3DRS/DUT/pe_array/#ASSIGN#598 { &{/test3DRS/DUT/swaddrgen/vectors2[13], /test3DRS/DUT/swaddrgen/vectors2[12], /test3DRS/DUT/swaddrgen/vectors2[11], /test3DRS/DUT/swaddrgen/vectors2[10], /test3DRS/DUT/swaddrgen/vectors2[9], /test3DRS/DUT/swaddrgen/vectors2[8], /test3DRS/DUT/swaddrgen/vectors2[7] }} vectors3_y
quietly virtual function -install /test3DRS/DUT/swaddrgen -env /test3DRS/DUT/pe_array/#ASSIGN#598 { &{/test3DRS/DUT/swaddrgen/vectors2[6], /test3DRS/DUT/swaddrgen/vectors2[5], /test3DRS/DUT/swaddrgen/vectors2[4], /test3DRS/DUT/swaddrgen/vectors2[3], /test3DRS/DUT/swaddrgen/vectors2[2], /test3DRS/DUT/swaddrgen/vectors2[1], /test3DRS/DUT/swaddrgen/vectors2[0] }} vectors2_x
add wave -noupdate -format Logic /test3DRS/outready
add wave -noupdate -format Literal /test3DRS/MVread
add wave -noupdate -format Literal /test3DRS/VecAddr
add wave -noupdate -format Literal /test3DRS/outSAD
add wave -noupdate -format Logic /test3DRS/blockend
add wave -noupdate -format Logic /test3DRS/frameend
add wave -noupdate -format Literal -radix decimal /test3DRS/SWcol
add wave -noupdate -format Literal -radix decimal /test3DRS/SWrow
add wave -noupdate -format Logic /test3DRS/clk
add wave -noupdate -format Logic /test3DRS/reset
add wave -noupdate -format Logic /test3DRS/start
add wave -noupdate -format Logic /test3DRS/firstframe
add wave -noupdate -format Logic /test3DRS/refwrite
add wave -noupdate -format Logic /test3DRS/searchwrite
add wave -noupdate -format Literal /test3DRS/refaddress
add wave -noupdate -format Literal /test3DRS/searchaddress
add wave -noupdate -format Literal -radix hexadecimal /test3DRS/refdata
add wave -noupdate -format Literal -radix hexadecimal /test3DRS/searchdata
add wave -noupdate -format Logic /test3DRS/curfilled
add wave -noupdate -format Logic /test3DRS/srcfilled
add wave -noupdate -format Literal /test3DRS/i
add wave -noupdate -format Literal /test3DRS/j
add wave -noupdate -format Literal /test3DRS/k
add wave -noupdate -format Literal /test3DRS/m
add wave -noupdate -format Literal /test3DRS/n
add wave -noupdate -format Literal /test3DRS/f1
add wave -noupdate -format Literal /test3DRS/f2
add wave -noupdate -format Literal /test3DRS/f3
add wave -noupdate -format Literal /test3DRS/a
add wave -noupdate -format Literal /test3DRS/b
add wave -noupdate -format Literal /test3DRS/c
add wave -noupdate -format Literal /test3DRS/rowblock
add wave -noupdate -format Literal /test3DRS/frameno
add wave -noupdate -format Literal -radix decimal /test3DRS/SWrowsigned
add wave -noupdate -format Literal -radix decimal /test3DRS/SWcolsigned
add wave -noupdate -format Logic /test3DRS/DUT/clk
add wave -noupdate -format Logic /test3DRS/DUT/reset
add wave -noupdate -format Logic /test3DRS/DUT/start
add wave -noupdate -format Logic /test3DRS/DUT/curfilled
add wave -noupdate -format Logic /test3DRS/DUT/srcfilled
add wave -noupdate -format Logic /test3DRS/DUT/firstframe
add wave -noupdate -format Literal /test3DRS/DUT/testAddr
add wave -noupdate -format Literal /test3DRS/DUT/testMV
add wave -noupdate -format Logic /test3DRS/DUT/blockendout
add wave -noupdate -format Logic /test3DRS/DUT/frameendout
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/update_y
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/update_x
add wave -noupdate -format Literal /test3DRS/DUT/updatevec
add wave -noupdate -format Logic /test3DRS/DUT/update_enable
add wave -noupdate -format Logic /test3DRS/DUT/SW_AddrGen_enable
add wave -noupdate -format Logic /test3DRS/DUT/MV_Process_Done
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/MVouty
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/MVoutx
add wave -noupdate -format Literal /test3DRS/DUT/MVout
add wave -noupdate -format Literal /test3DRS/DUT/MV1
add wave -noupdate -format Literal /test3DRS/DUT/MV2
add wave -noupdate -format Literal /test3DRS/DUT/MV3
add wave -noupdate -format Literal /test3DRS/DUT/curMV
add wave -noupdate -format Literal /test3DRS/DUT/selectedMV
add wave -noupdate -format Literal /test3DRS/DUT/MVarray_in
add wave -noupdate -format Literal -radix hexadecimal /test3DRS/DUT/SearchWin
add wave -noupdate -format Literal -radix hexadecimal /test3DRS/DUT/CurBlock
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/curSAD
add wave -noupdate -format Logic /test3DRS/DUT/cur_WE
add wave -noupdate -format Logic /test3DRS/DUT/search_WE
add wave -noupdate -format Literal -radix hexadecimal /test3DRS/DUT/cur_data_in
add wave -noupdate -format Logic /test3DRS/DUT/mv_array_WE
add wave -noupdate -format Logic /test3DRS/DUT/mvselect_WE
add wave -noupdate -format Logic /test3DRS/DUT/MVwait
add wave -noupdate -format Logic /test3DRS/DUT/rowend
add wave -noupdate -format Logic /test3DRS/DUT/feed
add wave -noupdate -format Logic /test3DRS/DUT/MVselect_done
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/curpos_y
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/curpos_x
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/curpos
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/MVout_x
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/MVout_y
add wave -noupdate -format Logic /test3DRS/DUT/feedvec
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/enable
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/SBFilled
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/updatein
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vecin_y
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vecin_x
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/vecin
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/MV_ready
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/Row_end
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/frame_end
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/outMV
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/done
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/feed
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/MVselect_WE
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/MVwait
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/swaddrgen/feedcount
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/inside
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/out
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/pre_median
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/median
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/pre_underTh
add wave -noupdate -format Logic /test3DRS/DUT/swaddrgen/underTh
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/swaddrgen/State
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vectors0_y
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vectors0_x
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/vectors0
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vectors1_y
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vectors1_x
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/vectors1
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vectors3_y
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/vectors2_x
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/vectors2
add wave -noupdate -format Literal /test3DRS/DUT/swaddrgen/medianMV
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/limited_out_x
add wave -noupdate -format Literal -radix decimal /test3DRS/DUT/swaddrgen/limited_out_y
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/WE
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/MVwait
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/mvselect/SADin
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MVin
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/mvselect/SADSelected
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MVSelected
add wave -noupdate -format Literal -radix unsigned /test3DRS/DUT/mvselect/SADmin
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MVmin
add wave -noupdate -format Literal -expand /test3DRS/DUT/mvselect/SADs
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MVs
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/count
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/WE_delay1
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/WE_delay2
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/WE_delay3
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/MVwait_delay1
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/MVwait_delay2
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MV_delay1
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MV_delay2
add wave -noupdate -format Literal /test3DRS/DUT/mvselect/MV_delay3
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/done
add wave -noupdate -format Logic /test3DRS/DUT/mvselect/done_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {116655072102 ps} 0}
configure wave -namecolwidth 180
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 2
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {18001211430 ps} {18001726767 ps}
