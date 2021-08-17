const colorPalettes = [	
    {hash: 0x3F6E70FF},
    {hash: 0x0105607B},
    {hash: 0x17CBCC83},
    {hash: 0x29F81B2A},
    {hash: 0x3385C5DB},
    {hash: 0x37CD36D4},
    {hash: 0x4101ED87},
    {hash: 0x63838A81},
    {hash: 0x6765BC15},
    {hash: 0x8BA18876},
    {hash: 0x9AC34F34},
    {hash: 0x9E4803A0},
    {hash: 0xA4041CEF},
    {hash: 0xA4CFABD0},
    {hash: 0xAA65D8A3},
    {hash: 0xB562025C},
    {hash: 0xB9E7F722},
    {hash: 0xBBF43EF8},
    {hash: 0xD1476963},
    {hash: 0xD799E1C2},
    {hash: 0xDC6BC93B},
    {hash: 0xDFB1F64C},
    {hash: 0xF509C745},
    {hash: 0xF93DB0C8},
    {hash: 0xFB71527B}
]

const textureTypes = {
	male :		
	{
		albedo:0,
		normal:GetHashKey("mp_head_mr1_000_nm"),
		material:0x50A4BBA9,
		color_type:1,
		texture_opacity:1.0,
		unk_arg:0,
	},		
	
	
	female : 
	{
		albedo:0,
		normal:GetHashKey("head_fr1_mp_002_nm"),
		material:0x7FC5B1E1, 
		color_type:1,
		texture_opacity:1.0,
		unk_arg:0
	}
}

const overlaysInfo = {

	eyebrows: [
		{id:0x07844317,albedo:0xF81B2E66,normal:0x7BC4288B,ma:0x202674A1,},    //   {albedo:"mp_u_faov_eyebrow_m_012_ab",normal:"mp_u_faov_eyebrow_m_012_nm",ma:"mp_u_faov_eyebrow_m_012_ma",},
		{id:0x0A83CA6E,albedo:0x8FA4286B,normal:0xBD811948,ma:0xB82C8FBB,},    //   {albedo:"mp_u_faov_eyebrow_m_006_ab",normal:"mp_u_faov_eyebrow_m_006_nm",ma:"mp_u_faov_eyebrow_m_006_ma",},
		{id:0x139A5CA3,albedo:0x487ABE5A,normal:0x22A9DDF9,ma:0x78AA9401,},    //   {albedo:"mp_u_faov_eyebrow_m_003_ab",normal:"mp_u_faov_eyebrow_m_003_nm",ma:"mp_u_faov_eyebrow_m_003_ma",},
		{id:0x1832E474,albedo:0x96FBB931,normal:0x32FA2683,ma:0xA1775B18,},    //   {albedo:"mp_u_faov_eyebrow_m_011_ab",normal:"mp_u_faov_eyebrow_m_011_nm",ma:"mp_u_faov_eyebrow_m_011_ma",},
		{id:0x216EF84C,albedo:0x269CD8F8,normal:0x2F54C727,ma:0xCCBD1939,},    //   {albedo:"mp_u_faov_eyebrow_m_002_ab",normal:"mp_u_faov_eyebrow_m_002_nm",ma:"mp_u_faov_eyebrow_m_002_ma",},
		{id:0x2594304D,albedo:0xA5A23CD1,normal:0x8611B42C,ma:0x0238302B,},    //   {albedo:"mp_u_faov_eyebrow_f_004_ab",normal:"mp_u_faov_eyebrow_f_004_nm",ma:"mp_u_faov_eyebrow_f_004_ma",},
		{id:0x33C39BC5,albedo:0xF928E29B,normal:0x46C268BD,ma:0x4B92F13E,},    //   {albedo:"mp_u_faov_eyebrow_m_013_ab",normal:"mp_u_faov_eyebrow_m_013_nm",ma:"mp_u_faov_eyebrow_m_013_ma",},
		{id:0x443E3CBA,albedo:0x6C83B571,normal:0x2B191070,ma:0xD551E623,},    //   {albedo:"mp_u_faov_eyebrow_m_014_ab",normal:"mp_u_faov_eyebrow_m_014_nm",ma:"mp_u_faov_eyebrow_m_014_ma",},
		{id:0x4F5052DE,albedo:0x827EEF46,normal:0x70E8C702,ma:0xD97518F9,},    //   {albedo:"mp_u_faov_eyebrow_m_015_ab",normal:"mp_u_faov_eyebrow_m_015_nm",ma:"mp_u_faov_eyebrow_m_015_ma",},
		{id:0x5C049D35,albedo:0x41E90506,normal:0x7E47D163,ma:0x54100288,},    //   {albedo:"mp_u_faov_eyebrow_f_001_ab",normal:"mp_u_faov_eyebrow_f_001_nm",ma:"mp_u_faov_eyebrow_f_001_ma",},
		{id:0x77A1546E,albedo:0x43C4AE44,normal:0x290FC7F7,ma:0xD8FC26A9,},    //   {albedo:"mp_u_faov_eyebrow_f_003_ab",normal:"mp_u_faov_eyebrow_f_003_nm",ma:"mp_u_faov_eyebrow_f_003_ma",},
		{id:0x8A4B79C2,albedo:0xAE6ED4E6,normal:0x89B29E5A,ma:0xFA0476E4,},    //   {albedo:"mp_u_faov_eyebrow_f_002_ab",normal:"mp_u_faov_eyebrow_f_002_nm",ma:"mp_u_faov_eyebrow_f_002_ma",},
		{id:0x9728137B,albedo:0x23E65D35,normal:0xEE39073F,ma:0x218DD4C8,},    //   {albedo:"mp_u_faov_eyebrow_f_006_ab",normal:"mp_u_faov_eyebrow_f_006_nm",ma:"mp_u_faov_eyebrow_f_006_ma",},
		{id:0xA6DE8325,albedo:0x7A93F649,normal:0x22B33B65,ma:0xEE6CCF11,},    //   {albedo:"mp_u_faov_eyebrow_m_008_ab",normal:"mp_u_faov_eyebrow_m_008_nm",ma:"mp_u_faov_eyebrow_m_008_ma",},
		{id:0xA8CCB6C4,albedo:0x29AD8BF9,normal:0x34ABB09D,ma:0xCF206860,},    //   {albedo:"mp_u_faov_eyebrow_f_005_ab",normal:"mp_u_faov_eyebrow_f_005_nm",ma:"mp_u_faov_eyebrow_f_005_ma",},
		{id:0xB3F74D19,albedo:0x3E2F71B1,normal:0xD4809D11,ma:0x9ABFA640,},    //   {albedo:"mp_u_faov_eyebrow_f_007_ab",normal:"mp_u_faov_eyebrow_f_007_nm",ma:"mp_u_faov_eyebrow_f_007_ma",},
		{id:0xBD38AFD9,albedo:0x058A698E,normal:0x9A732F86,ma:0x2EF1D769,},    //   {albedo:"mp_u_faov_eyebrow_m_007_ab",normal:"mp_u_faov_eyebrow_m_007_nm",ma:"mp_u_faov_eyebrow_m_007_ma",},
		{id:0xCD0A4F7C,albedo:0xED46998E,normal:0xB5B73A38,ma:0x15C5FB78,},    //   {albedo:"mp_u_faov_eyebrow_m_009_ab",normal:"mp_u_faov_eyebrow_m_009_nm",ma:"mp_u_faov_eyebrow_m_009_ma",},
		{id:0xD0EC86FF,albedo:0x81B462A2,normal:0x894F8744,ma:0x51551810,},    //   {albedo:"mp_u_faov_eyebrow_f_000_ab",normal:"mp_u_faov_eyebrow_f_000_nm",ma:"mp_u_faov_eyebrow_f_000_ma",},
		{id:0xEB088A20,albedo:0x0C6CDBDC,normal:0x91A2496E,ma:0xE639F138,},    //   {albedo:"mp_u_faov_eyebrow_m_010_ab",normal:"mp_u_faov_eyebrow_m_010_nm",ma:"mp_u_faov_eyebrow_m_010_ma",},
		{id:0xF0CA96FC,albedo:0xAC3BCA3F,normal:0x667FEFF8,ma:0xDD8E5EFF,},    //   {albedo:"mp_u_faov_eyebrow_m_005_ab",normal:"mp_u_faov_eyebrow_m_005_nm",ma:"mp_u_faov_eyebrow_m_005_ma",},
		{id:0xF3351BD9,albedo:0xC3286EA4,normal:0x8BB9158A,ma:0xFBBAE4D8,},    //   {albedo:"mp_u_faov_eyebrow_m_001_ab",normal:"mp_u_faov_eyebrow_m_001_nm",ma:"mp_u_faov_eyebrow_m_001_ma",},
		{id:0xF9052779,albedo:0x8AEADE78,normal:0x21BB2D97,ma:0x75A0B928,},    //   {albedo:"mp_u_faov_eyebrow_m_000_ab",normal:"mp_u_faov_eyebrow_m_000_nm",ma:"mp_u_faov_eyebrow_m_000_ma",},
		{id:0xFE183197,albedo:0x92B508CD,normal:0x6AA92A3E,ma:0xB4A436DB,},    //   {albedo:"mp_u_faov_eyebrow_m_004_ab",normal:"mp_u_faov_eyebrow_m_004_nm",ma:"mp_u_faov_eyebrow_m_004_ma",},
	],


	scars:     [
		{id:0xC8E45B5B,albedo:0x6245579F,normal:0xD53A336F,},       // {albedo:"mp_u_faov_scar_000_ab",normal:"mp_u_faov_scar_000_nm",},
		{id:0x90D86B44,albedo:0xA1538E6F,normal:0xDFCB1159,},       // {albedo:"mp_u_faov_scar_001_ab",normal:"mp_u_faov_scar_001_nm",},
		{id:0x23190FC3,albedo:0x39683ECE,normal:0x249C1A0A,},       // {albedo:"mp_u_faov_scar_002_ab",normal:"mp_u_faov_scar_002_nm",},
		{id:0x7574B47D,albedo:0x3AB2A0BB,normal:0x7A70886A,},       // {albedo:"mp_u_faov_scar_003_ab",normal:"mp_u_faov_scar_003_nm",},
		{id:0x7FE8C965,albedo:0xB81C8D16,normal:0x7210971B,},       // {albedo:"mp_u_faov_scar_004_ab",normal:"mp_u_faov_scar_004_nm",},
		{id:0x083059FE,albedo:0xC332710C,normal:0x860EE45E,},       // {albedo:"mp_u_faov_scar_005_ab",normal:"mp_u_faov_scar_005_nm",},
		{id:0x19E9FD71,albedo:0x40895310,normal:0xB753C5C7,},       // {albedo:"mp_u_faov_scar_006_ab",normal:"mp_u_faov_scar_006_nm",},
		{id:0x4CAF62FB,albedo:0xD80F2F64,normal:0x00BBF225,},       // {albedo:"mp_u_faov_scar_007_ab",normal:"mp_u_faov_scar_007_nm",},
		{id:0xDE650668,albedo:0x85F6BF71,normal:0x3DD0B0AE,},       // {albedo:"mp_u_faov_scar_008_ab",normal:"mp_u_faov_scar_008_nm",},
		{id:0xC648562B,albedo:0x6397E4D9,normal:0x2B59CDA1,},       // {albedo:"mp_u_faov_scar_009_ab",normal:"mp_u_faov_scar_009_nm",},
		{id:0x484BAEF8,albedo:0xBF2946DE,normal:0xD3F2F2F6,},       // {albedo:"mp_u_faov_scar_010_ab",normal:"mp_u_faov_scar_010_nm",},
		{id:0x190F5080,albedo:0xCBBDB741,normal:0x9518FA34,},       // {albedo:"mp_u_faov_scar_011_ab",normal:"mp_u_faov_scar_011_nm",},
		{id:0x2B5DF51D,albedo:0x0E05C415,normal:0x8B8C57AC,},       // {albedo:"mp_u_faov_scar_012_ab",normal:"mp_u_faov_scar_012_nm",},
		{id:0xE490E784,albedo:0x50853115,normal:0xDA7F2A1E,},       // {albedo:"mp_u_faov_scar_013_ab",normal:"mp_u_faov_scar_013_nm",},
		{id:0x0ED23C06,albedo:0xAEA45D76,normal:0x364DAAA6,},       // {albedo:"mp_u_faov_scar_014_ab",normal:"mp_u_faov_scar_014_nm",},
		{id:0x5712CCB6,albedo:0x9318AF61,normal:0x98104C8C,},       // {albedo:"mp_u_faov_scar_015_ab",normal:"mp_u_faov_scar_015_nm",},

	],  

	eyeliners : [
		{id:0x29A2E58F,albedo:0xA952BF75,ma:0xDD55AF2A,},                                                // {albedo:"mp_u_faov_eyeliner_000_ab",ma:"mp_u_faov_eyeliner_000_ma",},
	], 

	lipsticks : [
		{id:0x887E11E0,albedo:0x96A5E4FB,normal:0x1C77591C,ma:0x4255A5F4,},                              // {albedo:"mp_u_faov_lipstick_000_ab",normal:"mp_u_faov_lipstick_000_nm",ma:"mp_u_faov_lipstick_000_ma",},  // 7variantov
	], 

	acne :  [
		{id:0x96DD8F42,albedo:0x1BA4244B,normal:0xBA46CE92}                                           // {albedo:"mp_u_faov_acne_000_ab",normal:"mp_u_faov_acne_000_nm",},
	], 

	shadows : [
		{id:0x47BD7289,albedo:0x5C5C98FC,ma:0xE20345CC,},                                               // {albedo:"mp_u_faov_eyeshadow_000_ab",ma:"mp_u_faov_eyeshadow_000_ma",},  // 6 variantov
	], 

	beardstabble : [
		{id:0x375D4807,albedo:0xB5827817,normal:0x5041B648,ma:0x83F42340,},                              // {albedo:"mp_u_faov_beard_000_ab",normal:"mp_u_faov_beard_000_nm",ma:"mp_u_faov_beard_000_ma",},
	], 

	paintedmasks : [
		{id:0x5995AA6F,albedo:0x99BCB03F,},                                                              // {albedo:"mp_u_faov_masks_000_ab",},
	], 

	ageing  : [
		{id:0x96DD8F42,albedo:0x1BA4244B,normal:0xBA46CE92,},                                            // {albedo:"mp_u_faov_acne_000_ab",normal:"mp_u_faov_acne_000_nm",},
		{id:0x6D9DC405,albedo:0xAFE82F0C,normal:0x5CF8808E,},                                            // {albedo:"mp_u_faov_ageing_000_ab",normal:"mp_u_faov_ageing_000_nm",},
		{id:0x2761B792,albedo:0x4105C6B3,normal:0x8607CC56,},                                            // {albedo:"mp_u_faov_ageing_001_ab",normal:"mp_u_faov_ageing_001_nm",},
		{id:0x19009AD0,albedo:0xEBC18618,normal:0x9087AF96,},                                            // {albedo:"mp_u_faov_ageing_002_ab",normal:"mp_u_faov_ageing_002_nm",},
		{id:0xC29F6E07,albedo:0xF9887FA7,normal:0x1331C3C9,},                                            // {albedo:"mp_u_faov_ageing_003_ab",normal:"mp_u_faov_ageing_003_nm",},
		{id:0xA45F3187,albedo:0x1C30961A,normal:0x3CA2F3AE,},                                            // {albedo:"mp_u_faov_ageing_004_ab",normal:"mp_u_faov_ageing_004_nm",},
		{id:0x5E21250C,albedo:0x01E35044,normal:0x5A965FF0,},                                            // {albedo:"mp_u_faov_ageing_005_ab",normal:"mp_u_faov_ageing_005_nm",},
		{id:0x4FFE08C6,albedo:0xA65757F2,normal:0xC46CC005,},                                            // {albedo:"mp_u_faov_ageing_006_ab",normal:"mp_u_faov_ageing_006_nm",},
		{id:0x2DAD4485,albedo:0x358DEFDA,normal:0x55D317B4,},                                            // {albedo:"mp_u_faov_ageing_007_ab",normal:"mp_u_faov_ageing_007_nm",},
		{id:0x3F70680B,albedo:0x7073A58F,normal:0x33E73C5F,},                                            // {albedo:"mp_u_faov_ageing_008_ab",normal:"mp_u_faov_ageing_008_nm",},
		{id:0xD3310F8E,albedo:0xD9E8A605,normal:0x22297EA5,},                                            // {albedo:"mp_u_faov_ageing_009_ab",normal:"mp_u_faov_ageing_009_nm",},
		{id:0xF27A4C84,albedo:0xE0F0971B,normal:0x9F0E6718,},                                            // {albedo:"mp_u_faov_ageing_010_ab",normal:"mp_u_faov_ageing_010_nm",},
		{id:0x0044E819,albedo:0xFD844ADF,normal:0x315A6D56,},                                            // {albedo:"mp_u_faov_ageing_011_ab",normal:"mp_u_faov_ageing_011_nm",},
		{id:0xA648348D,albedo:0xC329F765,normal:0xE8CD7F20,},                                            // {albedo:"mp_u_faov_ageing_012_ab",normal:"mp_u_faov_ageing_012_nm",},
		{id:0x94F991F0,albedo:0x8586D19B,normal:0xCA334396,},                                            // {albedo:"mp_u_faov_ageing_013_ab",normal:"mp_u_faov_ageing_013_nm",},
		{id:0xCAACFD56,albedo:0xD2D0BF4F,normal:0xE0203BDA,},                                            // {albedo:"mp_u_faov_ageing_014_ab",normal:"mp_u_faov_ageing_014_nm",},
		{id:0xB9675ACB,albedo:0x2387AF71,normal:0x90A80AE1,},                                            // {albedo:"mp_u_faov_ageing_015_ab",normal:"mp_u_faov_ageing_015_nm",},
		{id:0x3C2CE03C,albedo:0xC6DCBCCA,normal:0x609B7EBD,},                                            // {albedo:"mp_u_faov_ageing_016_ab",normal:"mp_u_faov_ageing_016_nm",},
		{id:0xF2D64D90,albedo:0xC6DCBCCA,normal:0x609B7EBD,},                                            // {albedo:"mp_u_faov_ageing_016_ab",normal:"mp_u_faov_ageing_016_nm",},
		{id:0xE389AEF7,albedo:0xDF591FF2,normal:0x11D92A14,},                                            // {albedo:"mp_u_faov_ageing_018_ab",normal:"mp_u_faov_ageing_018_nm",},
		{id:0x89317A44,albedo:0xB4640D19,normal:0x2F56FDA5,},                                            // {albedo:"mp_u_faov_ageing_019_ab",normal:"mp_u_faov_ageing_019_nm",},
		{id:0x64B3347C,albedo:0xFF2E8F96,normal:0x45EE7B10,},                                            // {albedo:"mp_u_faov_ageing_020_ab",normal:"mp_u_faov_ageing_020_nm",},
		{id:0x9FFDAB10,albedo:0x8F2950D9,normal:0x85BDD7E8,},                                            // {albedo:"mp_u_faov_ageing_021_ab",normal:"mp_u_faov_ageing_021_nm",},
		{id:0x91D40EBD,albedo:0x5DCD1D4E,normal:0xA1B5F71F,},                                            // {albedo:"mp_u_faov_ageing_022_ab",normal:"mp_u_faov_ageing_022_nm",},
		{id:0x6B94C23F,albedo:0xF17FE41C,normal:0x0C480977,},                                            // {albedo:"mp_u_faov_ageing_023_ab",normal:"mp_u_faov_ageing_023_nm",},
	], 
	blush : [
		{id:0x6DB440FA,albedo:0x43B1AACA,},                                                              // {albedo:"mp_u_faov_blush_000_ab",},
		{id:0x47617455,albedo:0x9CAD2EF0,},                                                              // {albedo:"mp_u_faov_blush_001_ab",},
		{id:0x114D082D,albedo:0xA52E3B98,},                                                              // {albedo:"mp_u_faov_blush_002_ab",},
		{id:0xEC6F3E72,albedo:0xB5CED4CB,},                                                              // {albedo:"mp_u_faov_blush_003_ab",},
	], 
	complex : [
		{id:0xF679EDE7,albedo:0xFAAE9FF0,},                                                              // {albedo:"mp_u_faov_complex_000_ab",},
		{id:0x3FFB80ED,albedo:0x1FDFD4A1,},                                                              // {albedo:"mp_u_faov_complex_001_ab",},
		{id:0x31C0E478,albedo:0xC72D0698,},                                                              // {albedo:"mp_u_faov_complex_002_ab",},
		{id:0x2457C9A6,albedo:0x98F1C76F,},                                                              // {albedo:"mp_u_faov_complex_003_ab",},
		{id:0x16262D43,albedo:0xE0D03293,},                                                              // {albedo:"mp_u_faov_complex_004_ab",},
		{id:0x88F312DB,albedo:0x2ECCC670,},                                                              // {albedo:"mp_u_faov_complex_005_ab",},
		{id:0x785C71AE,albedo:0xAE1C329F,},                                                              // {albedo:"mp_u_faov_complex_006_ab",},
		{id:0x6D7D5BF0,albedo:0x23201E55,},                                                              // {albedo:"mp_u_faov_complex_007_ab",},
		{id:0x5F2FBF55,albedo:0x94503F97,},                                                              // {albedo:"mp_u_faov_complex_008_ab",},
		{id:0xBF38FF6A,albedo:0x5F62F986,},                                                              // {albedo:"mp_u_faov_complex_009_ab",},
		{id:0xF5656C26,albedo:0x83417009,},                                                              // {albedo:"mp_u_faov_complex_010_ab",},
		{id:0x03A408A3,albedo:0x1BCC4185,},                                                              // {albedo:"mp_u_faov_complex_011_ab",},
		{id:0x293453C3,albedo:0x6C556574,},                                                              // {albedo:"mp_u_faov_complex_012_ab",},
		{id:0x43150800,albedo:0x1E486F85,},                                                              // {albedo:"mp_u_faov_complex_013_ab",},
	], 
	disc  : [
		{id:0xD44A5ABA,albedo:0x2D3AEB2F,},                                                              // {albedo:"mp_u_faov_disc_000_ab",},
		{id:0xE2CF77C4,albedo:0xB8945AC0,},                                                              // {albedo:"mp_u_faov_disc_001_ab",},
		{id:0xCF57D0E9,albedo:0xB15E4E47,},                                                              // {albedo:"mp_u_faov_disc_002_ab",},
		{id:0xE0A8738A,albedo:0x25A711DD,},                                                              // {albedo:"mp_u_faov_disc_003_ab",},
		{id:0xABD109DC,albedo:0xCEBED6D9,},                                                              // {albedo:"mp_u_faov_disc_004_ab",},
		{id:0xB91C2472,albedo:0xFDD6C9AB,},                                                              // {albedo:"mp_u_faov_disc_005_ab",},
		{id:0x894844B7,albedo:0x7E89B165,},                                                              // {albedo:"mp_u_faov_disc_006_ab",},
		{id:0x96FAE01C,albedo:0x458799CD,},                                                              // {albedo:"mp_u_faov_disc_007_ab",},
		{id:0x86D3BFCE,albedo:0x8F2F2826,},                                                              // {albedo:"mp_u_faov_disc_008_ab",},
		{id:0x5488DB39,albedo:0xB49A0275,},                                                              // {albedo:"mp_u_faov_disc_009_ab",},
		{id:0x7DA5A5AE,albedo:0x8200F51D,},                                                              // {albedo:"mp_u_faov_disc_010_ab",},
		{id:0xE73778DC,albedo:0x8D35AC90,},                                                              // {albedo:"mp_u_faov_disc_011_ab",},
		{id:0xD83EDADF,albedo:0x96B619CD,},                                                              // {albedo:"mp_u_faov_disc_012_ab",},
		{id:0xE380F163,albedo:0xAB7309F7,},                                                              // {albedo:"mp_u_faov_disc_013_ab",},
		{id:0xB4611324,albedo:0x26FEBDD4,},                                                              // {albedo:"mp_u_faov_disc_014_ab",},
		{id:0xC6ABB7B9,albedo:0xC162C835,},                                                              // {albedo:"mp_u_faov_disc_015_ab",},
	], 
	foundation : [
		{id:0xEF5AB280,albedo:0xD9264247,ma:0x1535C7C9,},                                                // {albedo:"mp_u_faov_foundation_000_ab",ma:"mp_u_faov_foundation_000_ma",},
	], 
	freckles :  [
		{id:0x1B794C51,albedo:0x59B8159A,},                                                              // {albedo:"mp_u_faov_freckles_000_ab",},
		{id:0x29BFE8DE,albedo:0x03FCF67B,},                                                              // {albedo:"mp_u_faov_freckles_001_ab",},
		{id:0x0EF6B34C,albedo:0x21E2FD82,},                                                              // {albedo:"mp_u_faov_freckles_002_ab",},
		{id:0x64925E7E,albedo:0x3FD45844,},                                                              // {albedo:"mp_u_faov_freckles_003_ab",},
		{id:0xF5F280FC,albedo:0xE372E00E,},                                                              // {albedo:"mp_u_faov_freckles_004_ab",},
		{id:0x33B0FC78,albedo:0x288810E0,},                                                              // {albedo:"mp_u_faov_freckles_005_ab",},
		{id:0x25675FE5,albedo:0xEB8C0B1D,},                                                              // {albedo:"mp_u_faov_freckles_006_ab",},
		{id:0xD10F3736,albedo:0x3885AC2A,},                                                              // {albedo:"mp_u_faov_freckles_007_ab",},
		{id:0x5126B75F,albedo:0xB061C984,},                                                              // {albedo:"mp_u_faov_freckles_008_ab",},
		{id:0x6B8EEC2F,albedo:0xE1D1113E,},                                                              // {albedo:"mp_u_faov_freckles_009_ab",},
		{id:0x0A9A26F7,albedo:0xA1EC1AEA,},                                                              // {albedo:"mp_u_faov_freckles_010_ab",},
		{id:0xFDE40D8B,albedo:0x6DBC9203,},                                                              // {albedo:"mp_u_faov_freckles_011_ab",},
		{id:0x7E338E44,albedo:0x097D1D0A,},                                                              // {albedo:"mp_u_faov_freckles_012_ab",},
		{id:0x70F273C2,albedo:0x81A25BCE,},                                                              // {albedo:"mp_u_faov_freckles_013_ab",},
		{id:0x61C7D56D,albedo:0x197A1335,},                                                              // {albedo:"mp_u_faov_freckles_014_ab",},  
	], 
	grime : [
		{id:0xA2F30923,albedo:0x16CDD724,normal:0x136165B3,ma:0xF3DFA7AC,},                              // {albedo:"mp_u_faov_grime_000_ab",normal:"mp_u_faov_grime_000_nm",ma:"mp_u_faov_grime_000_ma",},
		{id:0xD5B1EEA0,albedo:0x0E599D69,normal:0x5C67FB68,ma:0x40FEC59E,},                              // {albedo:"mp_u_faov_grime_001_ab",normal:"mp_u_faov_grime_001_nm",ma:"mp_u_faov_grime_001_ma",},
		{id:0x7EC740CC,albedo:0x0FAE8DC6,normal:0x9E7A4B63,ma:0xB48BF65A,},                              // {albedo:"mp_u_faov_grime_002_ab",normal:"mp_u_faov_grime_002_nm",ma:"mp_u_faov_grime_002_ma",},
		{id:0xB08F245B,albedo:0x98358521,normal:0x1FAA4A84,ma:0x81428E8F,},                              // {albedo:"mp_u_faov_grime_003_ab",normal:"mp_u_faov_grime_003_nm",ma:"mp_u_faov_grime_003_ma",},
		{id:0x1A5E77F8,albedo:0x8D3D2563,normal:0x1FAA4A84,ma:0x81428E8F,},                              // {albedo:"mp_u_faov_grime_004_ab",normal:"mp_u_faov_grime_003_nm",ma:"mp_u_faov_grime_003_ma",},
		{id:0xE81B9373,albedo:0xAE43378D,normal:0x0CBEEF9B,ma:0x92097B22,},                              // {albedo:"mp_u_faov_grime_005_ab",normal:"mp_u_faov_grime_005_nm",ma:"mp_u_faov_grime_005_ma",},
		{id:0x3CFA3D2F,albedo:0x7499570E,normal:0xA27FF667,ma:0x24B49749,},                              // {albedo:"mp_u_faov_grime_006_ab",normal:"mp_u_faov_grime_006_nm",ma:"mp_u_faov_grime_006_ma",},
		{id:0x0B865A48,albedo:0xB80F6B12,normal:0x377319E3,ma:0x3CDC25A9,},                              // {albedo:"mp_u_faov_grime_007_ab",normal:"mp_u_faov_grime_007_nm",ma:"mp_u_faov_grime_007_ma",},
		{id:0x506DE416,albedo:0x537BA522,normal:0x006AF092,ma:0x5CCEA9F8,},                              // {albedo:"mp_u_faov_grime_008_ab",normal:"mp_u_faov_grime_008_nm",ma:"mp_u_faov_grime_008_ma",},
		{id:0x1F250185,albedo:0x51BE975D,normal:0x3F718027,ma:0x5527ACCF,},                              // {albedo:"mp_u_faov_grime_009_ab",normal:"mp_u_faov_grime_009_nm",ma:"mp_u_faov_grime_009_ma",},
		{id:0xE71930B0,albedo:0x595D09A3,normal:0xF4E08D43,ma:0x60B91CE7,},                              // {albedo:"mp_u_faov_grime_010_ab",normal:"mp_u_faov_grime_010_nm",ma:"mp_u_faov_grime_010_ma",},
		{id:0xDE571F2C,albedo:0xE7FAFDFA,normal:0xE6A18BBF,ma:0xCB315A57,},                              // {albedo:"mp_u_faov_grime_011_ab",normal:"mp_u_faov_grime_011_nm",ma:"mp_u_faov_grime_011_ma",},
		{id:0x0CA6FBCB,albedo:0x0E27372E,normal:0xD4894921,ma:0xBF339D56,},                              // {albedo:"mp_u_faov_grime_012_ab",normal:"mp_u_faov_grime_012_nm",ma:"mp_u_faov_grime_012_ma",},
		{id:0x21F62669,albedo:0x693623F0,normal:0xDB95176C,ma:0xEA27B375,},                              // {albedo:"mp_u_faov_grime_013_ab",normal:"mp_u_faov_grime_013_nm",ma:"mp_u_faov_grime_013_ma",},
		{id:0xFB09D881,albedo:0xC4A40DA0,normal:0xADD1DC3D,ma:0xFD797A87,},                              // {albedo:"mp_u_faov_grime_014_ab",normal:"mp_u_faov_grime_014_nm",ma:"mp_u_faov_grime_014_ma",},
		{id:0x11530513,albedo:0x67C6D30F,normal:0x26AA38C3,ma:0x89C2FFE3,},                              // {albedo:"mp_u_faov_grime_015_ab",normal:"mp_u_faov_grime_015_nm",ma:"mp_u_faov_grime_015_ma",},
	], 
	hairov :  [
		{id:0x39051515,albedo:0x60A4A360,normal:0x8D65EFF2,ma:0x62759D82,},                              // {albedo:"mp_u_faov_m_hair_000_ab",normal:"mp_u_faov_m_hair_000_nm",ma:"mp_u_faov_m_hair_000_ma",},
		{id:0x5E71DFEE,albedo:0x71147B90,ma:0xD8EB57BC,},                                                // {albedo:"mp_u_faov_m_hair_002_ab",ma:"mp_u_faov_m_hair_002_ma",},
		{id:0xDD735DEF,albedo:0x493214E4,ma:0x6613D121,},                                                // {albedo:"mp_u_faov_m_hair_009_ab",ma:"mp_u_faov_m_hair_009_ma",},
		{id:0x69622EAD,albedo:0xA6E819C4,ma:0xE581D851,},                                                // {albedo:"mp_u_faov_m_hair_shared_000_ab",ma:"mp_u_faov_m_hair_shared_000_ma",},
	], 
	moles : [
		{id:0x821FD077,albedo:0xDFDA0798,normal:0xE4E90C92,},                                            // {albedo:"mp_u_faov_moles_000_ab",normal:"mp_u_faov_moles_000_nm",},
		{id:0xCD38E6A8,albedo:0xE9CF623E,normal:0x43FAEA4B,},                                            // {albedo:"mp_u_faov_moles_001_ab",normal:"mp_u_faov_moles_001_nm",},
		{id:0x9F9D8B72,albedo:0x27450B2F,normal:0x0808DBFB,},                                            // {albedo:"mp_u_faov_moles_002_ab",normal:"mp_u_faov_moles_002_nm",},
		{id:0xE7179A39,albedo:0x38638E0B,normal:0x99346057,},                                            // {albedo:"mp_u_faov_moles_003_ab",normal:"mp_u_faov_moles_003_nm",},
		{id:0xBB094249,albedo:0x763F8624,normal:0x6975D6F9,},                                            // {albedo:"mp_u_faov_moles_004_ab",normal:"mp_u_faov_moles_004_nm",},
		{id:0x03AC5362,albedo:0xEF158115,normal:0xBA297751,},                                            // {albedo:"mp_u_faov_moles_005_ab",normal:"mp_u_faov_moles_005_nm",},
		{id:0x154FF6A9,albedo:0xEE28E6F7,normal:0xB7548307,},                                            // {albedo:"mp_u_faov_moles_006_ab",normal:"mp_u_faov_moles_006_nm",},
		{id:0x1E23084F,albedo:0x566ACE2F,normal:0x361237C6,},                                            // {albedo:"mp_u_faov_moles_007_ab",normal:"mp_u_faov_moles_007_nm",},
		{id:0x31DBAFC0,albedo:0x0AB0CC2B,normal:0xDBF55701,},                                            // {albedo:"mp_u_faov_moles_008_ab",normal:"mp_u_faov_moles_008_nm",},
		{id:0x3AC5C194,albedo:0xC940CC25,normal:0x41CB48FC,},                                            // {albedo:"mp_u_faov_moles_009_ab",normal:"mp_u_faov_moles_009_nm",},
		{id:0x4500D516,albedo:0x3A1EEDB1,normal:0x17BC19B0,},                                            // {albedo:"mp_u_faov_moles_010_ab",normal:"mp_u_faov_moles_010_nm",},
		{id:0x3695B840,albedo:0x1D30222E,normal:0xDA5FDF7E,},                                            // {albedo:"mp_u_faov_moles_011_ab",normal:"mp_u_faov_moles_011_nm",},
		{id:0x286C1BED,albedo:0x4F0B4FA8,normal:0x40333534,},                                            // {albedo:"mp_u_faov_moles_012_ab",normal:"mp_u_faov_moles_012_nm",},
		{id:0x934BF1AF,albedo:0x4540A8D7,normal:0x933ACF76,},                                            // {albedo:"mp_u_faov_moles_013_ab",normal:"mp_u_faov_moles_013_nm",},
		{id:0x84F55502,albedo:0x47BE6D32,normal:0xDCF7108E,},                                            // {albedo:"mp_u_faov_moles_014_ab",normal:"mp_u_faov_moles_014_nm",},
		{id:0xBD9A464B,albedo:0x9DABB1B9,normal:0x4A3B1739,},                                            // {albedo:"mp_u_faov_moles_015_ab",normal:"mp_u_faov_moles_015_nm",},
	], 
	spots : [
		{id:0x5BBFF5F7,albedo:0x24968425,normal:0xA5D532AD,},                                            // {albedo:"mp_u_faov_spots_000_ab",normal:"mp_u_faov_spots_000_nm",},
		{id:0x65EC0A4F,albedo:0x326A7845,normal:0xC09B2354,},                                            // {albedo:"mp_u_faov_spots_001_ab",normal:"mp_u_faov_spots_001_nm",},
		{id:0x3F143CA0,albedo:0x91D7E39E,normal:0xD607DF75,},                                            // {albedo:"mp_u_faov_spots_002_ab",normal:"mp_u_faov_spots_002_nm",},
		{id:0x49675146,albedo:0x2E6C3769,normal:0xE6A21CD5,},                                            // {albedo:"mp_u_faov_spots_003_ab",normal:"mp_u_faov_spots_003_nm",},
		{id:0x07504D2D,albedo:0x39F16CE6,normal:0x5CB32D5C,},                                            // {albedo:"mp_u_faov_spots_004_ab",normal:"mp_u_faov_spots_004_nm",},
		{id:0xF161214F,albedo:0x47C60FBA,normal:0x19424C77,},                                            // {albedo:"mp_u_faov_spots_005_ab",normal:"mp_u_faov_spots_005_nm",},
		{id:0xE43286F2,albedo:0xA7E86379,normal:0x7C07E0B0,},                                            // {albedo:"mp_u_faov_spots_006_ab",normal:"mp_u_faov_spots_006_nm",},
		{id:0xDDDC7A46,albedo:0x26D3DA64,normal:0x5A69A9BB,},                                            // {albedo:"mp_u_faov_spots_007_ab",normal:"mp_u_faov_spots_007_nm",},
		{id:0xD086DF9B,albedo:0x7D6FF58C,normal:0x5A0D99C8,},                                            // {albedo:"mp_u_faov_spots_008_ab",normal:"mp_u_faov_spots_008_nm",},
		{id:0xBA51B331,albedo:0xCB23CA55,normal:0xA7720C6A,},                                            // {albedo:"mp_u_faov_spots_009_ab",normal:"mp_u_faov_spots_009_nm",},
		{id:0xE4CF097B,albedo:0x51D0FBDA,normal:0xB01F5202,},                                            // {albedo:"mp_u_faov_spots_010_ab",normal:"mp_u_faov_spots_010_nm",},
		{id:0xF70CADF6,albedo:0xD0858DFC,normal:0x7E067837,},                                            // {albedo:"mp_u_faov_spots_011_ab",normal:"mp_u_faov_spots_011_nm",},
		{id:0xC07F40DC,albedo:0x3BAF1008,normal:0x75030E1B,},                                            // {albedo:"mp_u_faov_spots_012_ab",normal:"mp_u_faov_spots_012_nm",},
		{id:0xD3B1E741,albedo:0x97091388,normal:0xA191AA56,},                                            // {albedo:"mp_u_faov_spots_013_ab",normal:"mp_u_faov_spots_013_nm",},
		{id:0xB494A903,albedo:0x18025AE1,normal:0x86F51AD1,},                                            // {albedo:"mp_u_faov_spots_014_ab",normal:"mp_u_faov_spots_014_nm",},
		{id:0xC6EE4DB6,albedo:0xC9F3EBA4,normal:0xE819AD33,},                                            // {albedo:"mp_u_faov_spots_015_ab",normal:"mp_u_faov_spots_015_nm",},
	]
}

const clothOverlayItems = [
	{
		category_hashname:"AGING",	
		ped_type: "both",
		models:
		[
			[
				{hash: 0x0A196157, hashname: "CLOTHING_BLEND_AGING_01"},               // dec unsign, hashname: 169435479 dec sign, hashname: 169435479
				{hash: 0xDC5685D2, hashname: "CLOTHING_BLEND_AGING_02"},               // dec unsign, hashname: 3696657874 dec sign, hashname: -598309422
				{hash: 0x368B3A3E, hashname: "CLOTHING_BLEND_AGING_03"},               // dec unsign, hashname: 915094078 dec sign, hashname: 915094078
				{hash: 0x08B35E8B, hashname: "CLOTHING_BLEND_AGING_04"},               // dec unsign, hashname: 145972875 dec sign, hashname: 145972875
				{hash: 0x5330F389, hashname: "CLOTHING_BLEND_AGING_05"},               // dec unsign, hashname: 1395717001 dec sign, hashname: 1395717001
				{hash: 0x238A143C, hashname: "CLOTHING_BLEND_AGING_06"},               // dec unsign, hashname: 596251708 dec sign, hashname: 596251708
				{hash: 0x600E8D44, hashname: "CLOTHING_BLEND_AGING_07"},               // dec unsign, hashname: 1611566404 dec sign, hashname: 1611566404
				{hash: 0x424F51C6, hashname: "CLOTHING_BLEND_AGING_08"},               // dec unsign, hashname: 1112494534 dec sign, hashname: 1112494534
				{hash: 0x7E89CA3A, hashname: "CLOTHING_BLEND_AGING_09"},               // dec unsign, hashname: 2122959418 dec sign, hashname: 2122959418
				{hash: 0xDDFE07F9, hashname: "CLOTHING_BLEND_AGING_10"},               // dec unsign, hashname: 3724412921 dec sign, hashname: -570554375
				{hash: 0x5427744E, hashname: "CLOTHING_BLEND_AGING_11"},               // dec unsign, hashname: 1411871822 dec sign, hashname: 1411871822
				{hash: 0x424AD095, hashname: "CLOTHING_BLEND_AGING_12"},               // dec unsign, hashname: 1112199317 dec sign, hashname: 1112199317
				{hash: 0x3648B891, hashname: "CLOTHING_BLEND_AGING_13"},               // dec unsign, hashname: 910735505 dec sign, hashname: 910735505
				{hash: 0x24F795EF, hashname: "CLOTHING_BLEND_AGING_14"},               // dec unsign, hashname: 620205551 dec sign, hashname: 620205551
				{hash: 0x5B3A8274, hashname: "CLOTHING_BLEND_AGING_15"},               // dec unsign, hashname: 1530561140 dec sign, hashname: 1530561140
				{hash: 0x891CDE38, hashname: "CLOTHING_BLEND_AGING_16"},               // dec unsign, hashname: 2300370488 dec sign, hashname: -1994596808
				{hash: 0xBD7046D2, hashname: "CLOTHING_BLEND_AGING_17"},               // dec unsign, hashname: 3178251986 dec sign, hashname: -1116715310
				{hash: 0x6B5322A5, hashname: "CLOTHING_BLEND_AGING_18"},               // dec unsign, hashname: 1800610469 dec sign, hashname: 1800610469
				{hash: 0xA1FB8FE9, hashname: "CLOTHING_BLEND_AGING_19"},               // dec unsign, hashname: 2717618153 dec sign, hashname: -1577349143
				{hash: 0x689878DC, hashname: "CLOTHING_BLEND_AGING_20"},               // dec unsign, hashname: 1754822876 dec sign, hashname: 1754822876
				{hash: 0xFE93A4BC, hashname: "CLOTHING_BLEND_AGING_21"},               // dec unsign, hashname: 4271088828 dec sign, hashname: -23878468
				{hash: 0x0C524039, hashname: "CLOTHING_BLEND_AGING_22"},               // dec unsign, hashname: 206716985 dec sign, hashname: 206716985
				{hash: 0x2EAF04F6, hashname: "CLOTHING_BLEND_AGING_23"},               // dec unsign, hashname: 783222006 dec sign, hashname: 783222006
				{hash: 0x3C39A00B, hashname: "CLOTHING_BLEND_AGING_24"}               // dec unsign, hashname: 1010409483 dec sign, hashname: 1010409483
			]
		]
	},

	{
		category_hashname:"COMPLEXION",	
		ped_type: "both",
		models:
		[
			[
				{hash:0xA6548E94 , hashname: "CLOTHING_BLEND_COMPLEXION_NONE" },              // dec unsign, hashname: 2790559380 dec sign, hashname: -1504407916
				{hash:0x654C1AAA , hashname: "CLOTHING_BLEND_COMPLEXION_01"  },            // dec unsign, hashname: 1699486378 dec sign, hashname: 1699486378
				{hash:0x9F280E61 , hashname: "CLOTHING_BLEND_COMPLEXION_02"  },            // dec unsign, hashname: 2670202465 dec sign, hashname: -1624764831
				{hash:0x8D426A96 , hashname: "CLOTHING_BLEND_COMPLEXION_03"  },            // dec unsign, hashname: 2369940118 dec sign, hashname: -1925027178
				{hash:0xC0B3D178 , hashname: "CLOTHING_BLEND_COMPLEXION_04"  },            // dec unsign, hashname: 3233010040 dec sign, hashname: -1061957256
				{hash:0xAEC3AD98 , hashname: "CLOTHING_BLEND_COMPLEXION_05"  },            // dec unsign, hashname: 2932059544 dec sign, hashname: -1362907752
				{hash:0xE4319877 , hashname: "CLOTHING_BLEND_COMPLEXION_06"  },            // dec unsign, hashname: 3828455543 dec sign, hashname: -466511753
				{hash:0xD26874E1 , hashname: "CLOTHING_BLEND_COMPLEXION_07"  },            // dec unsign, hashname: 3530061025 dec sign, hashname: -764906271
				{hash:0x09AB636A , hashname: "CLOTHING_BLEND_COMPLEXION_08"  },            // dec unsign, hashname: 162227050 dec sign, hashname: 162227050
				{hash:0xF7E13FD6 , hashname: "CLOTHING_BLEND_COMPLEXION_09"  },            // dec unsign, hashname: 4158734294 dec sign, hashname: -136233002
				{hash:0x8BCF6918 , hashname: "CLOTHING_BLEND_COMPLEXION_10"  },            // dec unsign, hashname: 2345625880 dec sign, hashname: -1949341416
				{hash:0x7E3DCDF5 , hashname: "CLOTHING_BLEND_COMPLEXION_11"  },            // dec unsign, hashname: 2117979637 dec sign, hashname: 2117979637
				{hash:0xC12C53D1 , hashname: "CLOTHING_BLEND_COMPLEXION_12"  },            // dec unsign, hashname: 3240907729 dec sign, hashname: -1054059567
				{hash:0xB295B6A4 , hashname: "CLOTHING_BLEND_COMPLEXION_13"  },            // dec unsign, hashname: 2996156068 dec sign, hashname: -1298811228
				{hash:0xD76E8059 , hashname: "CLOTHING_BLEND_COMPLEXION_14"  },            // dec unsign, hashname: 3614343257 dec sign, hashname: -680624039
			]
		]
	},

	{
		category_hashname:"COMPLEXION_2",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0xAD60EFCD , hashname: "CLOTHING_BLEND_COMPLEXION_2_NONE" },                // dec unsign, hashname: 2908811213 dec sign, hashname: -1386156083
				{hash:0xB8256BAD , hashname: "CLOTHING_BLEND_COMPLEXION_2_01" },              // dec unsign, hashname: 3089460141 dec sign, hashname: -1205507155
				{hash:0xE5BEC6DF , hashname: "CLOTHING_BLEND_COMPLEXION_2_02" },              // dec unsign, hashname: 3854485215 dec sign, hashname: -440482081
				{hash:0x9353A20A , hashname: "CLOTHING_BLEND_COMPLEXION_2_03" },              // dec unsign, hashname: 2471731722 dec sign, hashname: -1823235574
				{hash:0x5F013982 , hashname: "CLOTHING_BLEND_COMPLEXION_2_04" },              // dec unsign, hashname: 1593915778 dec sign, hashname: 1593915778
				{hash:0x4456042C , hashname: "CLOTHING_BLEND_COMPLEXION_2_05" },              // dec unsign, hashname: 1146487852 dec sign, hashname: 1146487852
				{hash:0xC166FE4C , hashname: "CLOTHING_BLEND_COMPLEXION_2_06" },              // dec unsign, hashname: 3244752460 dec sign, hashname: -1050214836
				{hash:0xAFB15AE1 , hashname: "CLOTHING_BLEND_COMPLEXION_2_07" },              // dec unsign, hashname: 2947635937 dec sign, hashname: -1347331359
				{hash:0x1779AA54 , hashname: "CLOTHING_BLEND_COMPLEXION_2_08" },              // dec unsign, hashname: 393849428 dec sign, hashname: 393849428
				{hash:0x3E2AF7B6 , hashname: "CLOTHING_BLEND_COMPLEXION_2_09" },              // dec unsign, hashname: 1043003318 dec sign, hashname: 1043003318
				{hash:0x9E21368D , hashname: "CLOTHING_BLEND_COMPLEXION_2_10" },              // dec unsign, hashname: 2652976781 dec sign, hashname: -1641990515
				{hash:0xE7F7CA39 , hashname: "CLOTHING_BLEND_COMPLEXION_2_11" },              // dec unsign, hashname: 3891776057 dec sign, hashname: -403191239
				{hash:0x679A4980 , hashname: "CLOTHING_BLEND_COMPLEXION_2_12" },              // dec unsign, hashname: 1738164608 dec sign, hashname: 1738164608
				{hash:0x79C3EDD3 , hashname: "CLOTHING_BLEND_COMPLEXION_2_13" },              // dec unsign, hashname: 2042883539 dec sign, hashname: 2042883539
				{hash:0x433580B7 , hashname: "CLOTHING_BLEND_COMPLEXION_2_14" },              // dec unsign, hashname: 1127579831 dec sign, hashname: 1127579831	
			]
		]
	},


	{
		category_hashname:"FRECKLES",	
		ped_type: "both",
		models:
		[	
			[
				{hash: 0xDD978DA1, hashname: "CLOTHING_BLEND_FRECKLES_NONE" },               // dec unsign, hashname: 3717696929 dec sign, hashname: -57727036
				{hash: 0x075E6959, hashname: "CLOTHING_BLEND_FRECKLES_01"   },              // dec unsign, hashname: 123627865 dec sign, hashname: 123627865
				{hash: 0xFAA6CFEA, hashname: "CLOTHING_BLEND_FRECKLES_02"   },              // dec unsign, hashname: 4205236202 dec sign, hashname: -89731094
				{hash: 0x77F04A73, hashname: "CLOTHING_BLEND_FRECKLES_03"   },              // dec unsign, hashname: 2012236403 dec sign, hashname: 2012236403
				{hash: 0x2A382F04, hashname: "CLOTHING_BLEND_FRECKLES_04"   },              // dec unsign, hashname: 708325124 dec sign, hashname: 708325124
				{hash: 0x15620558, hashname: "CLOTHING_BLEND_FRECKLES_05"   },              // dec unsign, hashname: 358745432 dec sign, hashname: 358745432
				{hash: 0x4633E6FB, hashname: "CLOTHING_BLEND_FRECKLES_06"   },              // dec unsign, hashname: 1177806587 dec sign, hashname: 1177806587
				{hash: 0xD0E7FC61, hashname: "CLOTHING_BLEND_FRECKLES_07"   },              // dec unsign, hashname: 3504864353 dec sign, hashname: -790102943
				{hash: 0xBB9ED1CF, hashname: "CLOTHING_BLEND_FRECKLES_08"   },              // dec unsign, hashname: 3147747791 dec sign, hashname: -1147219505
				{hash: 0x6E4BB72A, hashname: "CLOTHING_BLEND_FRECKLES_09"   },              // dec unsign, hashname: 1850455850 dec sign, hashname: 1850455850
				{hash: 0x26BBA923, hashname: "CLOTHING_BLEND_FRECKLES_10"   },              // dec unsign, hashname: 649832739 dec sign, hashname: 649832739
				{hash: 0x13F28391, hashname: "CLOTHING_BLEND_FRECKLES_11"   }              // dec unsign, hashname: 334660497 dec sign, hashname: 334660497
			]
		]
	},

	{
		category_hashname:"GRIME",	
		ped_type: "both",
		models:
		[
			[
				{hash:0xCA976EE2, hashname: "CLOTHING_BLEND_GRIME_NONE"},               // dec unsign, hashname: 3398921954 dec sign, hashname: -896045342
				{hash:0x1C322CE6, hashname: "CLOTHING_BLEND_GRIME_01"},               // dec unsign, hashname: 473050342 dec sign, hashname: 473050342
				{hash:0x6688C192, hashname: "CLOTHING_BLEND_GRIME_02"},               // dec unsign, hashname: 1720238482 dec sign, hashname: 1720238482
				{hash:0x82C4FA0A, hashname: "CLOTHING_BLEND_GRIME_03"},               // dec unsign, hashname: 2193947146 dec sign, hashname: -2101020150
				{hash:0xE5043E8B, hashname: "CLOTHING_BLEND_GRIME_04"},               // dec unsign, hashname: 3842260619 dec sign, hashname: -452706677
				{hash:0x2F43D30D, hashname: "CLOTHING_BLEND_GRIME_05"},               // dec unsign, hashname: 792974093 dec sign, hashname: 792974093
				{hash:0x418D77A0, hashname: "CLOTHING_BLEND_GRIME_06"},               // dec unsign, hashname: 1099790240 dec sign, hashname: 1099790240
				{hash:0x1A2328CC, hashname: "CLOTHING_BLEND_GRIME_07"},               // dec unsign, hashname: 438511820 dec sign, hashname: 438511820
				{hash:0x9C58AD35, hashname: "CLOTHING_BLEND_GRIME_08"},               // dec unsign, hashname: 2623057205 dec sign, hashname: -1671910091
				{hash:0xE6804183, hashname: "CLOTHING_BLEND_GRIME_09"},               // dec unsign, hashname: 3867165059 dec sign, hashname: -427802237
				{hash:0xCA0509F5, hashname: "CLOTHING_BLEND_GRIME_10"},               // dec unsign, hashname: 3389327861 dec sign, hashname: -905639435
				{hash:0x4722042D, hashname: "CLOTHING_BLEND_GRIME_11"},               // dec unsign, hashname: 1193411629 dec sign, hashname: 1193411629
				{hash:0x554CA082, hashname: "CLOTHING_BLEND_GRIME_12"},               // dec unsign, hashname: 1431085186 dec sign, hashname: 1431085186
				{hash:0xA69DC327, hashname: "CLOTHING_BLEND_GRIME_13"},               // dec unsign, hashname: 2795356967 dec sign, hashname: -1499610329
				{hash:0x942B9E43, hashname: "CLOTHING_BLEND_GRIME_14"},               // dec unsign, hashname: 2485886531 dec sign, hashname: -1809080765
				{hash:0x724ADA82, hashname: "CLOTHING_BLEND_GRIME_15"},               // dec unsign, hashname: 1917508226 dec sign, hashname: 1917508226
				{hash:0x7FBFF56C, hashname: "CLOTHING_BLEND_GRIME_16"}               // dec unsign, hashname: 2143286636 dec sign, hashname: 2143286636
			]
		]
	},
	{
		category_hashname:"MOLES",	
		ped_type: "both",
		models:
		[	
			[		
				{hash:0x0B9CB027, hashname: "CLOTHING_BLEND_MOLES_NONE"},                // dec unsign, hashname: 194818087 dec sign, hashname: 194818087
				{hash:0x517B3E24, hashname: "CLOTHING_BLEND_MOLES_01"},                // dec unsign, hashname: 1367031332 dec sign, hashname: 1367031332
				{hash:0x9FBD5AA7, hashname: "CLOTHING_BLEND_MOLES_02"},                // dec unsign, hashname: 2679986855 dec sign, hashname: -1614980441
				{hash:0xBDD01674, hashname: "CLOTHING_BLEND_MOLES_03"},                // dec unsign, hashname: 3184531060 dec sign, hashname: -1110436236
				{hash:0xCF9B3A0A, hashname: "CLOTHING_BLEND_MOLES_04"},                // dec unsign, hashname: 3483056650 dec sign, hashname: -811910646
				{hash:0x8A923051, hashname: "CLOTHING_BLEND_MOLES_05"},                // dec unsign, hashname: 2324836433 dec sign, hashname: -1970130863
				{hash:0xEBA4F21D, hashname: "CLOTHING_BLEND_MOLES_06"},                // dec unsign, hashname: 3953455645 dec sign, hashname: -341511651
				{hash:0xF9540D7B, hashname: "CLOTHING_BLEND_MOLES_07"},                // dec unsign, hashname: 4183035259 dec sign, hashname: -111932037
				{hash:0x5BACD22B, hashname: "CLOTHING_BLEND_MOLES_08"},                // dec unsign, hashname: 1538052651 dec sign, hashname: 1538052651
				{hash:0x14B6C440, hashname: "CLOTHING_BLEND_MOLES_09"},                // dec unsign, hashname: 347522112 dec sign, hashname: 347522112
				{hash:0x45522AE6, hashname: "CLOTHING_BLEND_MOLES_10"},                // dec unsign, hashname: 1163012838 dec sign, hashname: 1163012838
				{hash:0x7874912A, hashname: "CLOTHING_BLEND_MOLES_11"},                // dec unsign, hashname: 2020905258 dec sign, hashname: 2020905258
				{hash:0x6ABEF5BF, hashname: "CLOTHING_BLEND_MOLES_12"},                // dec unsign, hashname: 1790899647 dec sign, hashname: 1790899647
				{hash:0x121DC47E, hashname: "CLOTHING_BLEND_MOLES_13"},                // dec unsign, hashname: 303940734 dec sign, hashname: 303940734
				{hash:0xFCD499EC, hashname: "CLOTHING_BLEND_MOLES_14"},                // dec unsign, hashname: 4241791468 dec sign, hashname: -53175828
				{hash:0x37698F15, hashname: "CLOTHING_BLEND_MOLES_15"},                // dec unsign, hashname: 929664789 dec sign, hashname: 929664789
				{hash:0x204760D1, hashname: "CLOTHING_BLEND_MOLES_16"}                // dec unsign, hashname: 541548753 dec sign, hashname: 541548753
			]
		]
	},
	{
		category_hashname:"SCABS",	
		ped_type: "both",
		models:
		[		
			[
				{hash:0x10F302A0, hashname: "CLOTHING_BLEND_SCABS_NONE"},                // dec unsign, hashname: 284361376 dec sign, hashname: 284361376	
				{hash:0x674E740C, hashname: "CLOTHING_BLEND_SCABS_01"},                // dec unsign, hashname: 1733194764 dec sign, hashname: 1733194764
				{hash:0x90724653, hashname: "CLOTHING_BLEND_SCABS_02"},                // dec unsign, hashname: 2423408211 dec sign, hashname: -1871559085
				{hash:0x4C31BDD3, hashname: "CLOTHING_BLEND_SCABS_03"},                // dec unsign, hashname: 1278328275 dec sign, hashname: 1278328275
				{hash:0x57B9D4D7, hashname: "CLOTHING_BLEND_SCABS_04"},                // dec unsign, hashname: 1471796439 dec sign, hashname: 1471796439
				{hash:0xF3350BD7, hashname: "CLOTHING_BLEND_SCABS_05"},                // dec unsign, hashname: 4080339927 dec sign, hashname: -214627369
				{hash:0x3C441DEC, hashname: "CLOTHING_BLEND_SCABS_06"},                // dec unsign, hashname: 1011097068 dec sign, hashname: 1011097068
				{hash:0x66117186, hashname: "CLOTHING_BLEND_SCABS_07"},                // dec unsign, hashname: 1712419206 dec sign, hashname: 1712419206
				{hash:0xBEB3A2D5, hashname: "CLOTHING_BLEND_SCABS_08"},                // dec unsign, hashname: 3199443669 dec sign, hashname: -1095523627
				{hash:0xB086067A, hashname: "CLOTHING_BLEND_SCABS_09"},                // dec unsign, hashname: 2961573498 dec sign, hashname: -1333393798
				{hash:0x25A5EFA0, hashname: "CLOTHING_BLEND_SCABS_10"},                // dec unsign, hashname: 631631776 dec sign, hashname: 631631776
			]
		]
	},
	{
		category_hashname:"SCAR",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0x6027BA1E, hashname: "CLOTHING_BLEND_SCAR_NONE"},                // dec unsign, hashname: 1613216286 dec sign, hashname: 1613216286
				{hash:0xEAA072D7, hashname: "CLOTHING_BLEND_SCAR_01"},                // dec unsign, hashname: 3936383703 dec sign, hashname: -358583593
				{hash:0xDFF15D79, hashname: "CLOTHING_BLEND_SCAR_02"},                // dec unsign, hashname: 3757137273 dec sign, hashname: -537830023
				{hash:0xE5C5E926, hashname: "CLOTHING_BLEND_SCAR_03"},                // dec unsign, hashname: 3854952742 dec sign, hashname: -440014554
				{hash:0xDB79D48E, hashname: "CLOTHING_BLEND_SCAR_04"},                // dec unsign, hashname: 3682194574 dec sign, hashname: -612772722
				{hash:0xC14F2039, hashname: "CLOTHING_BLEND_SCAR_05"},                // dec unsign, hashname: 3243188281 dec sign, hashname: -1051779015
				{hash:0xB71E0BD7, hashname: "CLOTHING_BLEND_SCAR_06"},                // dec unsign, hashname: 3072199639 dec sign, hashname: -1222767657
				{hash:0xA4DBE753, hashname: "CLOTHING_BLEND_SCAR_07"},                // dec unsign, hashname: 2765875027 dec sign, hashname: -1529092269
				{hash:0x928242A0, hashname: "CLOTHING_BLEND_SCAR_08"},                // dec unsign, hashname: 2458010272 dec sign, hashname: -1836957024
				{hash:0x6002DD9A, hashname: "CLOTHING_BLEND_SCAR_09"},                // dec unsign, hashname: 1610800538 dec sign, hashname: 1610800538
				{hash:0xEF7DFB6A, hashname: "CLOTHING_BLEND_SCAR_10"},                // dec unsign, hashname: 4018010986 dec sign, hashname: -276956310
				{hash:0xA9B1EFD3, hashname: "CLOTHING_BLEND_SCAR_11"},                // dec unsign, hashname: 2847010771 dec sign, hashname: -1447956525
				{hash:0x92EFC24F, hashname: "CLOTHING_BLEND_SCAR_12"},                // dec unsign, hashname: 2465186383 dec sign, hashname: -1829780913
				{hash:0xAD597726, hashname: "CLOTHING_BLEND_SCAR_13"},                // dec unsign, hashname: 2908321574 dec sign, hashname: -1386645722
				{hash:0x96124898, hashname: "CLOTHING_BLEND_SCAR_14"},                // dec unsign, hashname: 2517780632 dec sign, hashname: -1777186664
				{hash:0x90C4BDFD, hashname: "CLOTHING_BLEND_SCAR_15"},                // dec unsign, hashname: 2428812797 dec sign, hashname: -1866154499
				{hash:0x7A769161, hashname: "CLOTHING_BLEND_SCAR_16"}                // dec unsign, hashname: 2054590817 dec sign, hashname: 2054590817
			]
		]
	},	
	{
		category_hashname:"SCAR",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0x6027BA1E, hashname: "CLOTHING_BLEND_SCAR_NONE"},                // dec unsign, hashname: 1613216286 dec sign, hashname: 1613216286
				{hash:0xEAA072D7, hashname: "CLOTHING_BLEND_SCAR_01"},                // dec unsign, hashname: 3936383703 dec sign, hashname: -358583593
				{hash:0xDFF15D79, hashname: "CLOTHING_BLEND_SCAR_02"},                // dec unsign, hashname: 3757137273 dec sign, hashname: -537830023
				{hash:0xE5C5E926, hashname: "CLOTHING_BLEND_SCAR_03"},                // dec unsign, hashname: 3854952742 dec sign, hashname: -440014554
				{hash:0xDB79D48E, hashname: "CLOTHING_BLEND_SCAR_04"},                // dec unsign, hashname: 3682194574 dec sign, hashname: -612772722
				{hash:0xC14F2039, hashname: "CLOTHING_BLEND_SCAR_05"},                // dec unsign, hashname: 3243188281 dec sign, hashname: -1051779015
				{hash:0xB71E0BD7, hashname: "CLOTHING_BLEND_SCAR_06"},                // dec unsign, hashname: 3072199639 dec sign, hashname: -1222767657
				{hash:0xA4DBE753, hashname: "CLOTHING_BLEND_SCAR_07"},                // dec unsign, hashname: 2765875027 dec sign, hashname: -1529092269
				{hash:0x928242A0, hashname: "CLOTHING_BLEND_SCAR_08"},                // dec unsign, hashname: 2458010272 dec sign, hashname: -1836957024
				{hash:0x6002DD9A, hashname: "CLOTHING_BLEND_SCAR_09"},                // dec unsign, hashname: 1610800538 dec sign, hashname: 1610800538
				{hash:0xEF7DFB6A, hashname: "CLOTHING_BLEND_SCAR_10"},                // dec unsign, hashname: 4018010986 dec sign, hashname: -276956310
				{hash:0xA9B1EFD3, hashname: "CLOTHING_BLEND_SCAR_11"},                // dec unsign, hashname: 2847010771 dec sign, hashname: -1447956525
				{hash:0x92EFC24F, hashname: "CLOTHING_BLEND_SCAR_12"},                // dec unsign, hashname: 2465186383 dec sign, hashname: -1829780913
				{hash:0xAD597726, hashname: "CLOTHING_BLEND_SCAR_13"},                // dec unsign, hashname: 2908321574 dec sign, hashname: -1386645722
				{hash:0x96124898, hashname: "CLOTHING_BLEND_SCAR_14"},                // dec unsign, hashname: 2517780632 dec sign, hashname: -1777186664
				{hash:0x90C4BDFD, hashname: "CLOTHING_BLEND_SCAR_15"},                // dec unsign, hashname: 2428812797 dec sign, hashname: -1866154499
				{hash:0x7A769161, hashname: "CLOTHING_BLEND_SCAR_16"}                // dec unsign, hashname: 2054590817 dec sign, hashname: 2054590817
			]
		]
	},


	{
		category_hashname:"SKIN_MOTTLING",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0x66CEC98A, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_01"},                // dec unsign, hashname: 1724828042 dec sign, hashname: 1724828042
				{hash:0x14192420, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_02"},                // dec unsign, hashname: 337191968 dec sign, hashname: 337191968
				{hash:0xFDF277D3, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_03"},                // dec unsign, hashname: 4260526035 dec sign, hashname: -34441261
				{hash:0xEB9ED32C, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_04"},                // dec unsign, hashname: 3953054508 dec sign, hashname: -341912788
				{hash:0xE17CBEE8, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_05"},                // dec unsign, hashname: 3783048936 dec sign, hashname: -511918360
				{hash:0xCF221A33, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_06"},                // dec unsign, hashname: 3475118643 dec sign, hashname: -819848653
				{hash:0xEDC65773, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_07"},                // dec unsign, hashname: 3989198707 dec sign, hashname: -305768589
				{hash:0x9BF633D4, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_08"},                // dec unsign, hashname: 2616603604 dec sign, hashname: -1678363692
				{hash:0xD0D09D88, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_09"},                // dec unsign, hashname: 3503332744 dec sign, hashname: -791634552
				{hash:0x729E68C1, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_10"},                // dec unsign, hashname: 1922984129 dec sign, hashname: 1922984129
				{hash:0x276C525E, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_11"},                // dec unsign, hashname: 661410398 dec sign, hashname: 661410398
				{hash:0x59B336EB, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_12"},                // dec unsign, hashname: 1504917227 dec sign, hashname: 1504917227
				{hash:0xBBC2FB09, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_13"},                // dec unsign, hashname: 3150117641 dec sign, hashname: -1144849655
				{hash:0xAE305FE4, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_14"},                // dec unsign, hashname: 2922405860 dec sign, hashname: -1372561436
				{hash:0x5E71C068, hashname: "CLOTHING_BLEND_SKIN_MOTTLING_15"},                // dec unsign, hashname: 1584513128 dec sign, hashname: 1584513128
			]
		]
	},

	{
		category_hashname:"SPOTS",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0xCD94CE89, hashname: "CLOTHING_BLEND_SPOTS_NONE"},                // dec unsign, hashname: 3449081481 dec sign, hashname: -845885815
				{hash:0x9781C03C, hashname: "CLOTHING_BLEND_SPOTS_01"},                // dec unsign, hashname: 2541862972 dec sign, hashname: -1753104324
				{hash:0xA9B464A1, hashname: "CLOTHING_BLEND_SPOTS_02"},                // dec unsign, hashname: 2847171745 dec sign, hashname: -1447795551
				{hash:0xBC0D8957, hashname: "CLOTHING_BLEND_SPOTS_03"},                // dec unsign, hashname: 3155003735 dec sign, hashname: -1139963561
				{hash:0xCE372DAA, hashname: "CLOTHING_BLEND_SPOTS_04"},                // dec unsign, hashname: 3459722666 dec sign, hashname: -835244630
				{hash:0x6B77E825, hashname: "CLOTHING_BLEND_SPOTS_05"},                // dec unsign, hashname: 1803020325 dec sign, hashname: 1803020325
				{hash:0x7DBD8CB0, hashname: "CLOTHING_BLEND_SPOTS_06"},                // dec unsign, hashname: 2109574320 dec sign, hashname: 2109574320
				{hash:0xA0F5D320, hashname: "CLOTHING_BLEND_SPOTS_07"},                // dec unsign, hashname: 2700464928 dec sign, hashname: -1594502368
				{hash:0xB33C77AD, hashname: "CLOTHING_BLEND_SPOTS_08"},                // dec unsign, hashname: 3007084461 dec sign, hashname: -1287882835
				{hash:0x361C7D73, hashname: "CLOTHING_BLEND_SPOTS_09"},                // dec unsign, hashname: 907836787 dec sign, hashname: 907836787
				{hash:0x30ECEFC0, hashname: "CLOTHING_BLEND_SPOTS_10"},                // dec unsign, hashname: 820834240 dec sign, hashname: 820834240
				{hash:0x90562E91, hashname: "CLOTHING_BLEND_SPOTS_11"},                // dec unsign, hashname: 2421567121 dec sign, hashname: -1873400175
				{hash:0x5DA04926, hashname: "CLOTHING_BLEND_SPOTS_12"},                // dec unsign, hashname: 1570785574 dec sign, hashname: 1570785574
				{hash:0x6BEA65BA, hashname: "CLOTHING_BLEND_SPOTS_13"},                // dec unsign, hashname: 1810523578 dec sign, hashname: 1810523578
				{hash:0x39158011, hashname: "CLOTHING_BLEND_SPOTS_14"},                // dec unsign, hashname: 957710353 dec sign, hashname: 957710353
				{hash:0xD89BBF1F, hashname: "CLOTHING_BLEND_SPOTS_15"},                // dec unsign, hashname: 3634085663 dec sign, hashname: -660881633
				{hash:0xA6B9DB58, hashname: "CLOTHING_BLEND_SPOTS_16"},                // dec unsign, hashname: 2797198168 dec sign, hashname: -1497769128
			]
		]
	},


	{
		category_hashname:"SPOTS_2",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0x25C8A50D, hashname: "CLOTHING_BLEND_SPOTS_2_NONE"},                // dec unsign, hashname: 633906445 dec sign, hashname: 633906445
				{hash:0xDBB47B39, hashname: "CLOTHING_BLEND_SPOTS_2_01"},                // dec unsign, hashname: 3686038329 dec sign, hashname: -608928967
				{hash:0xAD859EDC, hashname: "CLOTHING_BLEND_SPOTS_2_02"},                // dec unsign, hashname: 2911215324 dec sign, hashname: -1383751972
				{hash:0xF71F321E, hashname: "CLOTHING_BLEND_SPOTS_2_03"},                // dec unsign, hashname: 4146016798 dec sign, hashname: -148950498
				{hash:0xC955567B, hashname: "CLOTHING_BLEND_SPOTS_2_04"},                // dec unsign, hashname: 3377813115 dec sign, hashname: -917154181
				{hash:0x84F2CDC3, hashname: "CLOTHING_BLEND_SPOTS_2_05"},                // dec unsign, hashname: 2230504899 dec sign, hashname: -2064462397
				{hash:0x964FF07D, hashname: "CLOTHING_BLEND_SPOTS_2_06"},                // dec unsign, hashname: 2521821309 dec sign, hashname: -1773145987
				{hash:0xA057848C, hashname: "CLOTHING_BLEND_SPOTS_2_07"},                // dec unsign, hashname: 2690090124 dec sign, hashname: -1604877172
				{hash:0xB399AB10, hashname: "CLOTHING_BLEND_SPOTS_2_08"},                // dec unsign, hashname: 3013192464 dec sign, hashname: -1281774832
				{hash:0x4DDB5F95, hashname: "CLOTHING_BLEND_SPOTS_2_09"},                // dec unsign, hashname: 1306222485 dec sign, hashname: 1306222485
				{hash:0x46215105, hashname: "CLOTHING_BLEND_SPOTS_2_10"},                // dec unsign, hashname: 1176588549 dec sign, hashname: 1176588549
				{hash:0x8066458E, hashname: "CLOTHING_BLEND_SPOTS_2_11"},                // dec unsign, hashname: 2154186126 dec sign, hashname: -2140781170
				{hash:0x3270A9A4, hashname: "CLOTHING_BLEND_SPOTS_2_12"},                // dec unsign, hashname: 846244260 dec sign, hashname: 846244260
				{hash:0xFBA7BC1F, hashname: "CLOTHING_BLEND_SPOTS_2_13"},                // dec unsign, hashname: 4222073887 dec sign, hashname: -72893409
				{hash:0xED681FA0, hashname: "CLOTHING_BLEND_SPOTS_2_14"},                // dec unsign, hashname: 3983024032 dec sign, hashname: -311943264
				{hash:0x5742F354, hashname: "CLOTHING_BLEND_SPOTS_2_15"},                // dec unsign, hashname: 1464005460 dec sign, hashname: 1464005460
				{hash:0x490056CF, hashname: "CLOTHING_BLEND_SPOTS_2_16"},                // dec unsign, hashname: 1224758991 dec sign, hashname: 1224758991
			]
		]
	},

	{
		category_hashname:"BLUSH",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0xDAC5F237, hashname: "CLOTHING_ITEM_BLUSH_000_TINT_001"},                // dec unsign, hashname: 3670405687 dec sign, hashname: -624561609
				{hash:0xE3E97354, hashname: "CLOTHING_ITEM_BLUSH_001_TINT_001"},                // dec unsign, hashname: 3823727444 dec sign, hashname: -471239852
				{hash:0x6E8FECE0, hashname: "CLOTHING_ITEM_BLUSH_002_TINT_001"},                // dec unsign, hashname: 1854926048 dec sign, hashname: 1854926048
				{hash:0xA8A0C891, hashname: "CLOTHING_ITEM_BLUSH_003_TINT_001"},                // dec unsign, hashname: 2829109393 dec sign, hashname: -1465857903
			]
		]
	},
	{
		category_hashname:"EYELINER",	
		ped_type: "both",
		models:
		[	
			[
				{hash:0x751AB598, hashname: "CLOTHING_BLEND_EYELINER_NONE"},         // dec unsign, hashname: 1964684696 dec sign, hashname: 1964684696  
				{hash:0xF1743538, hashname: "CLOTHING_ITEM_EYELINER_000_TINT_001"},                // dec unsign, hashname: 4050924856 dec sign, hashname: -244042440
				{hash:0xEE7B03B8, hashname: "CLOTHING_ITEM_EYELINER_001_TINT_001"},                // dec unsign, hashname: 4001039288 dec sign, hashname: -293928008
				{hash:0x307BA944, hashname: "CLOTHING_ITEM_EYELINER_002_TINT_001"},                // dec unsign, hashname: 813410628 dec sign, hashname: 813410628
				{hash:0x06050D11, hashname: "CLOTHING_ITEM_EYELINER_003_TINT_001"},                // dec unsign, hashname: 100994321 dec sign, hashname: 100994321
				{hash:0x94FE5AEF, hashname: "CLOTHING_ITEM_EYELINER_004_TINT_001"},                // dec unsign, hashname: 2499697391 dec sign, hashname: -1795269905
				{hash:0xCCB25726, hashname: "CLOTHING_ITEM_EYELINER_005_TINT_001"},                // dec unsign, hashname: 3434239782 dec sign, hashname: -860727514
			]
		]
	},

	{
		category_hashname:"EYESHADOW",	
		ped_type: "both",
		models:
		[
			[		
				{hash:0x8393707F, hashname: "CLOTHING_BLEND_EYESHADOW_NONE"},                // dec unsign, hashname: 2207477887 dec sign, hashname: -2087489409
			],
			[
				{hash:0xB2E60098, hashname: "CLOTHING_ITEM_EYESHADOW_000"},                // dec unsign, hashname: 3001417880 dec sign, hashname: -1293549416
				{hash:0xA4290F02, hashname: "CLOTHING_ITEM_EYESHADOW_000_TINT_001"},                // dec unsign, hashname: 2754154242 dec sign, hashname: -1540813054
				{hash:0x0E73E396, hashname: "CLOTHING_ITEM_EYESHADOW_000_TINT_002"},                // dec unsign, hashname: 242475926 dec sign, hashname: 242475926
				{hash:0x624B8B3C, hashname: "CLOTHING_ITEM_EYESHADOW_000_TINT_003"},                // dec unsign, hashname: 1649118012 dec sign, hashname: 1649118012
				{hash:0xD3CAEE39, hashname: "CLOTHING_ITEM_EYESHADOW_000_TINT_004"},                // dec unsign, hashname: 3553291833 dec sign, hashname: -741675463
			],
			[	
				{hash:0xC4A5A417, hashname: "CLOTHING_ITEM_EYESHADOW_001"},                // dec unsign, hashname: 3299189783 dec sign, hashname: -995777513
				{hash:0xF9315CBC, hashname: "CLOTHING_ITEM_EYESHADOW_001_TINT_001"},                // dec unsign, hashname: 4180761788 dec sign, hashname: -114205508
				{hash:0xEE1D4688, hashname: "CLOTHING_ITEM_EYESHADOW_001_TINT_002"},                // dec unsign, hashname: 3994896008 dec sign, hashname: -300071288
				{hash:0xA1CCAE0C, hashname: "CLOTHING_ITEM_EYESHADOW_001_TINT_003"},                // dec unsign, hashname: 2714545676 dec sign, hashname: -1580421620
				{hash:0xE783B955, hashname: "CLOTHING_ITEM_EYESHADOW_001_TINT_004"},                // dec unsign, hashname: 3884169557 dec sign, hashname: -410797739
			],
			[	
				{hash:0xE06ADBA1, hashname: "CLOTHING_ITEM_EYESHADOW_002"},                // dec unsign, hashname: 3765099425 dec sign, hashname: -529867871
				{hash:0x5A02075B, hashname: "CLOTHING_ITEM_EYESHADOW_002_TINT_001"},                // dec unsign, hashname: 1510082395 dec sign, hashname: 1510082395
				{hash:0x8B71EA3A, hashname: "CLOTHING_ITEM_EYESHADOW_002_TINT_002"},                // dec unsign, hashname: 2339498554 dec sign, hashname: -1955468742
				{hash:0xB1EB3728, hashname: "CLOTHING_ITEM_EYESHADOW_002_TINT_003"},                // dec unsign, hashname: 2984982312 dec sign, hashname: -1309984984
				{hash:0x9EB290B7, hashname: "CLOTHING_ITEM_EYESHADOW_002_TINT_004"},                // dec unsign, hashname: 2662502583 dec sign, hashname: -1632464713
			],
			[	
				{hash:0xF1F37EB2, hashname: "CLOTHING_ITEM_EYESHADOW_003"},                // dec unsign, hashname: 4059266738 dec sign, hashname: -235700558
				{hash:0xD8819174, hashname: "CLOTHING_ITEM_EYESHADOW_003_TINT_001"},                // dec unsign, hashname: 3632370036 dec sign, hashname: -662597260
				{hash:0xCB8A7786, hashname: "CLOTHING_ITEM_EYESHADOW_003_TINT_002"},                // dec unsign, hashname: 3414849414 dec sign, hashname: -880117882
				{hash:0xFD54DB1A, hashname: "CLOTHING_ITEM_EYESHADOW_003_TINT_003"},                // dec unsign, hashname: 4250196762 dec sign, hashname: -44770534
				{hash:0xE81DB0AC, hashname: "CLOTHING_ITEM_EYESHADOW_003_TINT_004"},                // dec unsign, hashname: 3894259884 dec sign, hashname: -400707412
			],
			[
				{hash:0xE922ED39, hashname: "CLOTHING_ITEM_EYESHADOW_004"},                // dec unsign, hashname: 3911380281 dec sign, hashname: -383587015
				{hash:0x79CFF3FB, hashname: "CLOTHING_ITEM_EYESHADOW_004_TINT_001"},                // dec unsign, hashname: 2043671547 dec sign, hashname: 2043671547
				{hash:0xF9B373C0, hashname: "CLOTHING_ITEM_EYESHADOW_004_TINT_002"},                // dec unsign, hashname: 4189287360 dec sign, hashname: -105679936
				{hash:0xEB79D74D, hashname: "CLOTHING_ITEM_EYESHADOW_004_TINT_003"},                // dec unsign, hashname: 3950630733 dec sign, hashname: -344336563
				{hash:0xD435A8C5, hashname: "CLOTHING_ITEM_EYESHADOW_004_TINT_004"},                // dec unsign, hashname: 3560286405 dec sign, hashname: -734680891
			],
			[	
				{hash:0xCB6AB1C9, hashname: "CLOTHING_ITEM_EYESHADOW_005"},                // dec unsign, hashname: 3412767177 dec sign, hashname: -882200119
				{hash:0x10138D70, hashname: "CLOTHING_ITEM_EYESHADOW_005_TINT_001"},                // dec unsign, hashname: 269716848 dec sign, hashname: 269716848
				{hash:0x1E5229ED, hashname: "CLOTHING_ITEM_EYESHADOW_005_TINT_002"},                // dec unsign, hashname: 508701165 dec sign, hashname: 508701165
				{hash:0x35BFD8C8, hashname: "CLOTHING_ITEM_EYESHADOW_005_TINT_003"},                // dec unsign, hashname: 901765320 dec sign, hashname: 901765320
				{hash:0x3C16E576, hashname: "CLOTHING_ITEM_EYESHADOW_005_TINT_004"},                // dec unsign, hashname: 1008133494 dec sign, hashname: 1008133494
				
			]	
		]
	},


	{
		category_hashname:"EYEBROWS",
		ped_type: "female",
		models:
		[
			[
				{hash:0x8BFCCE37, hashname: "CLOTHING_ITEM_F_EYEBROWS_001"},                // dec unsign, hashname: 2348600887 dec sign, hashname: -1946366409
				{hash:0xF15D768B, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_BLONDE"},                // dec unsign, hashname: 4049434251 dec sign, hashname: -245533045
				{hash:0x50ACD994, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_BROWN"},                // dec unsign, hashname: 1353505172 dec sign, hashname: 1353505172
				{hash:0x9F763893, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_DARKEST_BROWN"},                // dec unsign, hashname: 2675325075 dec sign, hashname: -1619642221
				{hash:0x9262C2B4, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_DARK_BLONDE"},                // dec unsign, hashname: 2455945908 dec sign, hashname: -1839021388
				{hash:0xAB5FD62E, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_DARK_GINGER"},                // dec unsign, hashname: 2875184686 dec sign, hashname: -1419782610
				{hash:0x383D68ED, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_DARK_GREY"},                // dec unsign, hashname: 943548653 dec sign, hashname: 943548653
				{hash:0x2513B162, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_GINGER"},                // dec unsign, hashname: 622047586 dec sign, hashname: 622047586
				{hash:0x5F344E42, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_GREY"},                // dec unsign, hashname: 1597263426 dec sign, hashname: 1597263426
				{hash:0x66AD3846, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_JET_BLACK"},                // dec unsign, hashname: 1722628166 dec sign, hashname: 1722628166
				{hash:0x9AFF621F, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_LIGHT_BLONDE"},                // dec unsign, hashname: 2600428063 dec sign, hashname: -1694539233
				{hash:0x5A383AD0, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_LIGHT_BROWN"},                // dec unsign, hashname: 1513634512 dec sign, hashname: 1513634512
				{hash:0xCAC113B8, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_LIGHT_GINGER"},                // dec unsign, hashname: 3401651128 dec sign, hashname: -893316168
				{hash:0x201E7CFA, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_LIGHT_GREY"},                // dec unsign, hashname: 538868986 dec sign, hashname: 538868986
				{hash:0x99FCDC9E, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_MEDIUM_BROWN"},                // dec unsign, hashname: 2583485598 dec sign, hashname: -1711481698
				{hash:0x4EA35955, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_SALT_PEPPER"},                // dec unsign, hashname: 1319328085 dec sign, hashname: 1319328085
				{hash:0x745C5808, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1952208904 dec sign, hashname: 1952208904
				{hash:0xDFB36C14, hashname: "CLOTHING_ITEM_F_EYEBROWS_001_UNCLE_GREY"},                // dec unsign, hashname: 3753077780 dec sign, hashname: -541889516
			],
			[
				{hash:0x7DE8B20F, hashname: "CLOTHING_ITEM_F_EYEBROWS_002"},                // dec unsign, hashname: 2112401935 dec sign, hashname: 2112401935
				{hash:0x5CD7D277, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_BLONDE"},                // dec unsign, hashname: 1557647991 dec sign, hashname: 1557647991
				{hash:0x9A095797, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_BROWN"},                // dec unsign, hashname: 2584303511 dec sign, hashname: -1710663785
				{hash:0xEB057D2B, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_DARKEST_BROWN"},                // dec unsign, hashname: 3943005483 dec sign, hashname: -351961813
				{hash:0xD0A7AD3E, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_DARK_BLONDE"},                // dec unsign, hashname: 3500649790 dec sign, hashname: -794317506
				{hash:0xFFE1C646, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_DARK_GINGER"},                // dec unsign, hashname: 4292986438 dec sign, hashname: -1980858
				{hash:0x9B7A19B4, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_DARK_GREY"},                // dec unsign, hashname: 2608470452 dec sign, hashname: -1686496844
				{hash:0xA62F9853, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_GINGER"},                // dec unsign, hashname: 2788137043 dec sign, hashname: -1506830253
				{hash:0x4967B9D5, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_GREY"},                // dec unsign, hashname: 1231534549 dec sign, hashname: 1231534549
				{hash:0x7C747BC9, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_JET_BLACK"},                // dec unsign, hashname: 2088008649 dec sign, hashname: 2088008649
				{hash:0x2BB3172C, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_LIGHT_BLONDE"},                // dec unsign, hashname: 733157164 dec sign, hashname: 733157164
				{hash:0x6ED62E46, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_LIGHT_BROWN"},                // dec unsign, hashname: 1859530310 dec sign, hashname: 1859530310
				{hash:0x8E6F9998, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_LIGHT_GINGER"},                // dec unsign, hashname: 2389678488 dec sign, hashname: -1905288808
				{hash:0x2E5ED192, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_LIGHT_GREY"},                // dec unsign, hashname: 777965970 dec sign, hashname: 777965970
				{hash:0xB8180A48, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_MEDIUM_BROWN"},                // dec unsign, hashname: 3088583240 dec sign, hashname: -1206384056
				{hash:0x0FC3EF79, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_SALT_PEPPER"},                // dec unsign, hashname: 264499065 dec sign, hashname: 264499065
				{hash:0x6A21A54B, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1780589899 dec sign, hashname: 1780589899
				{hash:0x25C62917, hashname: "CLOTHING_ITEM_F_EYEBROWS_002_UNCLE_GREY"},                // dec unsign, hashname: 633743639 dec sign, hashname: 633743639
			],
			[		
				{hash:0x70221682, hashname: "CLOTHING_ITEM_F_EYEBROWS_003"},                // dec unsign, hashname: 1881282178 dec sign, hashname: 1881282178
				{hash:0x0F4D901D, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_BLONDE"},                // dec unsign, hashname: 256741405 dec sign, hashname: 256741405
				{hash:0xBFBF1CD4, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_BROWN"},                // dec unsign, hashname: 3216973012 dec sign, hashname: -1077994284
				{hash:0x29E48AA8, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_DARKEST_BROWN"},                // dec unsign, hashname: 702843560 dec sign, hashname: 702843560
				{hash:0xCB994983, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_DARK_BLONDE"},                // dec unsign, hashname: 3415820675 dec sign, hashname: -879146621
				{hash:0xBA764626, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_DARK_GINGER"},                // dec unsign, hashname: 3128313382 dec sign, hashname: -1166653914
				{hash:0x1ED0BFFD, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_DARK_GREY"},                // dec unsign, hashname: 516997117 dec sign, hashname: 516997117
				{hash:0xA4C3B73C, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_GINGER"},                // dec unsign, hashname: 2764289852 dec sign, hashname: -1530677444
				{hash:0xE9ECAC9E, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_GREY"},                // dec unsign, hashname: 3924602014 dec sign, hashname: -370365282
				{hash:0x32B2D7FF, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_JET_BLACK"},                // dec unsign, hashname: 850581503 dec sign, hashname: 850581503
				{hash:0x3DDE1D73, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_LIGHT_BLONDE"},                // dec unsign, hashname: 1037966707 dec sign, hashname: 1037966707
				{hash:0x73645E64, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_LIGHT_BROWN"},                // dec unsign, hashname: 1935957604 dec sign, hashname: 1935957604
				{hash:0x21FF256C, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_LIGHT_GINGER"},                // dec unsign, hashname: 570369388 dec sign, hashname: 570369388
				{hash:0x69A29180, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_LIGHT_GREY"},                // dec unsign, hashname: 1772261760 dec sign, hashname: 1772261760
				{hash:0x3D5BBE16, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_MEDIUM_BROWN"},                // dec unsign, hashname: 1029422614 dec sign, hashname: 1029422614
				{hash:0x1E054528, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_SALT_PEPPER"},                // dec unsign, hashname: 503661864 dec sign, hashname: 503661864
				{hash:0x634A7F00, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1665826560 dec sign, hashname: 1665826560
				{hash:0x874030FC, hashname: "CLOTHING_ITEM_F_EYEBROWS_003_UNCLE_GREY"},                // dec unsign, hashname: 2269131004 dec sign, hashname: -2025836292
			],
			[	
				{hash:0xE273FB24, hashname: "CLOTHING_ITEM_F_EYEBROWS_004"},                // dec unsign, hashname: 3799251748 dec sign, hashname: -495715548
				{hash:0x3F6A93FB, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_BLONDE"},                // dec unsign, hashname: 1063949307 dec sign, hashname: 1063949307
				{hash:0x6F22D87E, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_BROWN"},                // dec unsign, hashname: 1864554622 dec sign, hashname: 1864554622
				{hash:0x607156AB, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_DARKEST_BROWN"},                // dec unsign, hashname: 1618040491 dec sign, hashname: 1618040491
				{hash:0x1642F17C, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_DARK_BLONDE"},                // dec unsign, hashname: 373485948 dec sign, hashname: 373485948
				{hash:0x309C68EA, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_DARK_GINGER"},                // dec unsign, hashname: 815556842 dec sign, hashname: 815556842
				{hash:0x45BCEAAE, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_DARK_GREY"},                // dec unsign, hashname: 1170008750 dec sign, hashname: 1170008750
				{hash:0x6267A6B9, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_GINGER"},                // dec unsign, hashname: 1650960057 dec sign, hashname: 1650960057
				{hash:0xA5748F94, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_GREY"},                // dec unsign, hashname: 2775879572 dec sign, hashname: -1519087724
				{hash:0xB7D2FF5A, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_JET_BLACK"},                // dec unsign, hashname: 3084058458 dec sign, hashname: -1210908838
				{hash:0x74D448AC, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_LIGHT_BLONDE"},                // dec unsign, hashname: 1960069292 dec sign, hashname: 1960069292
				{hash:0xA5A9E210, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_LIGHT_BROWN"},                // dec unsign, hashname: 2779374096 dec sign, hashname: -1515593200
				{hash:0x94D81AA9, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_LIGHT_GINGER"},                // dec unsign, hashname: 2497190569 dec sign, hashname: -1797776727
				{hash:0x37799315, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_LIGHT_GREY"},                // dec unsign, hashname: 930714389 dec sign, hashname: 930714389
				{hash:0x4C39E408, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_MEDIUM_BROWN"},                // dec unsign, hashname: 1278862344 dec sign, hashname: 1278862344
				{hash:0x1F60963E, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_SALT_PEPPER"},                // dec unsign, hashname: 526423614 dec sign, hashname: 526423614
				{hash:0x29A1A9BE, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 698460606 dec sign, hashname: 698460606
				{hash:0xF649C860, hashname: "CLOTHING_ITEM_F_EYEBROWS_004_UNCLE_GREY"},                // dec unsign, hashname: 4132030560 dec sign, hashname: -162936736
			],
			[
				{hash:0x3DE2B204, hashname: "CLOTHING_ITEM_F_EYEBROWS_005"},                // dec unsign, hashname: 1038266884 dec sign, hashname: 1038266884
				{hash:0x4722FC74, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_BLONDE"},                // dec unsign, hashname: 1193475188 dec sign, hashname: 1193475188
				{hash:0x059CD0FD, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_BROWN"},                // dec unsign, hashname: 94163197 dec sign, hashname: 94163197
				{hash:0x18F26778, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_DARKEST_BROWN"},                // dec unsign, hashname: 418539384 dec sign, hashname: 418539384
				{hash:0x2CCDEDBD, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_DARK_BLONDE"},                // dec unsign, hashname: 751693245 dec sign, hashname: 751693245
				{hash:0xEA39F8DE, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_DARK_GINGER"},                // dec unsign, hashname: 3929667806 dec sign, hashname: -365299490
				{hash:0xBB7901C2, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_DARK_GREY"},                // dec unsign, hashname: 3145269698 dec sign, hashname: -1149697598
				{hash:0x6B1CAA90, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_GINGER"},                // dec unsign, hashname: 1797040784 dec sign, hashname: 1797040784
				{hash:0xC5929156, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_GREY"},                // dec unsign, hashname: 3314717014 dec sign, hashname: -980250282
				{hash:0x9F17C8BC, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_JET_BLACK"},                // dec unsign, hashname: 2669136060 dec sign, hashname: -1625831236
				{hash:0x14905DF7, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_LIGHT_BLONDE"},                // dec unsign, hashname: 345005559 dec sign, hashname: 345005559
				{hash:0xD576F896, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_LIGHT_BROWN"},                // dec unsign, hashname: 3581343894 dec sign, hashname: -713623402
				{hash:0x307CE115, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_LIGHT_GINGER"},                // dec unsign, hashname: 813490453 dec sign, hashname: 813490453
				{hash:0x181F18B0, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_LIGHT_GREY"},                // dec unsign, hashname: 404691120 dec sign, hashname: 404691120
				{hash:0x75FA3A72, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_MEDIUM_BROWN"},                // dec unsign, hashname: 1979333234 dec sign, hashname: 1979333234
				{hash:0x01B48C8F, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_SALT_PEPPER"},                // dec unsign, hashname: 28609679 dec sign, hashname: 28609679
				{hash:0x3C22CC1A, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1008913434 dec sign, hashname: 1008913434
				{hash:0xBA9E6AA0, hashname: "CLOTHING_ITEM_F_EYEBROWS_005_UNCLE_GREY"},                // dec unsign, hashname: 3130944160 dec sign, hashname: -1164023136
			],
			[
				{hash:0x3030169F, hashname: "CLOTHING_ITEM_F_EYEBROWS_006"},                // dec unsign, hashname: 808457887 dec sign, hashname: 808457887
				{hash:0xA759C5C7, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_BLONDE"},                // dec unsign, hashname: 2807678407 dec sign, hashname: -1487288889
				{hash:0x135E5300, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_BROWN"},                // dec unsign, hashname: 324948736 dec sign, hashname: 324948736
				{hash:0x0912DD80, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_DARKEST_BROWN"},                // dec unsign, hashname: 152231296 dec sign, hashname: 152231296
				{hash:0xAFECA00F, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_DARK_BLONDE"},                // dec unsign, hashname: 2951520271 dec sign, hashname: -1343447025
				{hash:0x6D7CC132, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_DARK_GINGER"},                // dec unsign, hashname: 1836892466 dec sign, hashname: 1836892466
				{hash:0xD16DE6AC, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_DARK_GREY"},                // dec unsign, hashname: 3513640620 dec sign, hashname: -781326676
				{hash:0xB9670A2F, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_GINGER"},                // dec unsign, hashname: 3110537775 dec sign, hashname: -1184429521
				{hash:0x58C9156D, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_GREY"},                // dec unsign, hashname: 1489573229 dec sign, hashname: 1489573229
				{hash:0x5ADD9A6F, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_JET_BLACK"},                // dec unsign, hashname: 1524472431 dec sign, hashname: 1524472431
				{hash:0x5DF49FEE, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_LIGHT_BLONDE"},                // dec unsign, hashname: 1576312814 dec sign, hashname: 1576312814
				{hash:0x505876B0, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_LIGHT_BROWN"},                // dec unsign, hashname: 1347974832 dec sign, hashname: 1347974832
				{hash:0x34B8859C, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_LIGHT_GINGER"},                // dec unsign, hashname: 884508060 dec sign, hashname: 884508060
				{hash:0x01133B3B, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_LIGHT_GREY"},                // dec unsign, hashname: 18037563 dec sign, hashname: 18037563
				{hash:0xF7A1AD20, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_MEDIUM_BROWN"},                // dec unsign, hashname: 4154567968 dec sign, hashname: -140399328
				{hash:0x6AE8BB40, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_SALT_PEPPER"},                // dec unsign, hashname: 1793637184 dec sign, hashname: 1793637184
				{hash:0x71FD9B13, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1912445715 dec sign, hashname: 1912445715
				{hash:0x04D02E81, hashname: "CLOTHING_ITEM_F_EYEBROWS_006_UNCLE_GREY"},                // dec unsign, hashname: 80752257 dec sign, hashname: 80752257
			],
			[
				{hash:0xA2DCFBEB, hashname: "CLOTHING_ITEM_F_EYEBROWS_007"},                // dec unsign, hashname: 2732391403 dec sign, hashname: -1562575893
				{hash:0x8EBEA74D, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_BLONDE"},                // dec unsign, hashname: 2394859341 dec sign, hashname: -1900107955
				{hash:0x0CD665AF, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_BROWN"},                // dec unsign, hashname: 215377327 dec sign, hashname: 215377327
				{hash:0x192637E2, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_DARKEST_BROWN"},                // dec unsign, hashname: 421935074 dec sign, hashname: 421935074
				{hash:0x63F44516, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_DARK_BLONDE"},                // dec unsign, hashname: 1676952854 dec sign, hashname: 1676952854
				{hash:0x7B5F294E, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_DARK_GINGER"},                // dec unsign, hashname: 2069834062 dec sign, hashname: 2069834062
				{hash:0x3A789616, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_DARK_GREY"},                // dec unsign, hashname: 980981270 dec sign, hashname: 980981270
				{hash:0x94F11DE4, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_GINGER"},                // dec unsign, hashname: 2498829796 dec sign, hashname: -1796137500
				{hash:0xAACCD308, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_GREY"},                // dec unsign, hashname: 2865550088 dec sign, hashname: -1429417208
				{hash:0x3E3E39C8, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_JET_BLACK"},                // dec unsign, hashname: 1044265416 dec sign, hashname: 1044265416
				{hash:0xB296B58D, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_LIGHT_BLONDE"},                // dec unsign, hashname: 2996221325 dec sign, hashname: -1298745971
				{hash:0x9D120355, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_LIGHT_BROWN"},                // dec unsign, hashname: 2635203413 dec sign, hashname: -1659763883
				{hash:0x230DA56A, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_LIGHT_GINGER"},                // dec unsign, hashname: 588096874 dec sign, hashname: 588096874
				{hash:0x29C0BD8D, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_LIGHT_GREY"},                // dec unsign, hashname: 700497293 dec sign, hashname: 700497293
				{hash:0x1368D7F1, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_MEDIUM_BROWN"},                // dec unsign, hashname: 325638129 dec sign, hashname: 325638129
				{hash:0x9530D2B6, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_SALT_PEPPER"},                // dec unsign, hashname: 2503004854 dec sign, hashname: -1791962442
				{hash:0x44845FA6, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1149525926 dec sign, hashname: 1149525926
				{hash:0xB2E2AB88, hashname: "CLOTHING_ITEM_F_EYEBROWS_007_UNCLE_GREY"},                // dec unsign, hashname: 3001199496 dec sign, hashname: -1293767800
			],
			[
				{hash:0x7534A09B, hashname: "CLOTHING_ITEM_F_EYEBROWS_008"},                // dec unsign, hashname: 1966383259 dec sign, hashname: 1966383259
				{hash:0x4E8D5B11, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_BLONDE"},                // dec unsign, hashname: 1317886737 dec sign, hashname: 1317886737
				{hash:0xF8C3DFEA, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_BROWN"},                // dec unsign, hashname: 4173586410 dec sign, hashname: -121380886
				{hash:0x527D5112, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_DARKEST_BROWN"},                // dec unsign, hashname: 1383944466 dec sign, hashname: 1383944466
				{hash:0xAF08A630, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_DARK_BLONDE"},                // dec unsign, hashname: 2936579632 dec sign, hashname: -1358387664
				{hash:0x57592E54, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_DARK_GINGER"},                // dec unsign, hashname: 1465462356 dec sign, hashname: 1465462356
				{hash:0xB65AB78F, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_DARK_GREY"},                // dec unsign, hashname: 3059398543 dec sign, hashname: -1235568753
				{hash:0x1AA009C9, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_GINGER"},                // dec unsign, hashname: 446695881 dec sign, hashname: 446695881
				{hash:0x07FFD750, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_GREY"},                // dec unsign, hashname: 134207312 dec sign, hashname: 134207312
				{hash:0xB1D05172, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_JET_BLACK"},                // dec unsign, hashname: 2983219570 dec sign, hashname: -1311747726
				{hash:0xD7DE0CA7, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_LIGHT_BLONDE"},                // dec unsign, hashname: 3621653671 dec sign, hashname: -673313625
				{hash:0x5ECB92EF, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_LIGHT_BROWN"},                // dec unsign, hashname: 1590399727 dec sign, hashname: 1590399727
				{hash:0xF95686CE, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_LIGHT_GINGER"},                // dec unsign, hashname: 4183197390 dec sign, hashname: -111769906
				{hash:0x11EEA72A, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_LIGHT_GREY"},                // dec unsign, hashname: 300853034 dec sign, hashname: 300853034
				{hash:0xC98207F9, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_MEDIUM_BROWN"},                // dec unsign, hashname: 3380742137 dec sign, hashname: -914225159
				{hash:0x59001B63, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_SALT_PEPPER"},                // dec unsign, hashname: 1493179235 dec sign, hashname: 1493179235
				{hash:0xAFBF5582, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 2948552066 dec sign, hashname: -1346415230
				{hash:0x515F815C, hashname: "CLOTHING_ITEM_F_EYEBROWS_008_UNCLE_GREY"},                // dec unsign, hashname: 1365213532 dec sign, hashname: 1365213532
			],
			[
				{hash:0x307B10C7, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_BLONDE"},                // dec unsign, hashname: 813371591 dec sign, hashname: 813371591
				{hash:0xB801B2C5, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_BROWN"},                // dec unsign, hashname: 3087119045 dec sign, hashname: -1207848251
				{hash:0xC4793151, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_DARKEST_BROWN"},                // dec unsign, hashname: 3296276817 dec sign, hashname: -998690479
				{hash:0xA888FCBF, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_DARK_BLONDE"},                // dec unsign, hashname: 2827549887 dec sign, hashname: -1467417409
				{hash:0xA1F27158, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_DARK_GINGER"},                // dec unsign, hashname: 2717020504 dec sign, hashname: -1577946792
				{hash:0xB2E9FBEA, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_DARK_GREY"},                // dec unsign, hashname: 3001678826 dec sign, hashname: -1293288470
				{hash:0xC14CCF3E, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_GINGER"},                // dec unsign, hashname: 3243036478 dec sign, hashname: -1051930818
				{hash:0x737C19B7, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_GREY"},                // dec unsign, hashname: 1937512887 dec sign, hashname: 1937512887
				{hash:0x950F7495, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_JET_BLACK"},                // dec unsign, hashname: 2500818069 dec sign, hashname: -1794149227
				{hash:0x0A5ED520, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_LIGHT_BLONDE"},                // dec unsign, hashname: 173987104 dec sign, hashname: 173987104
				{hash:0x85008D5E, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_LIGHT_BROWN"},                // dec unsign, hashname: 2231405918 dec sign, hashname: -2063561378
				{hash:0xD578F607, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_LIGHT_GINGER"},                // dec unsign, hashname: 3581474311 dec sign, hashname: -713492985
				{hash:0x34C71294, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_LIGHT_GREY"},                // dec unsign, hashname: 885461652 dec sign, hashname: 885461652
				{hash:0xC4F2D721, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_MEDIUM_BROWN"},                // dec unsign, hashname: 3304249121 dec sign, hashname: -990718175
				{hash:0xA7C73A50, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_SALT_PEPPER"},                // dec unsign, hashname: 2814851664 dec sign, hashname: -1480115632
				{hash:0x18F337A1, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 418592673 dec sign, hashname: 418592673
				{hash:0x3471F7FF, hashname: "CLOTHING_ITEM_F_EYEBROWS_009_UNCLE_GREY"},                // dec unsign, hashname: 879884287 dec sign, hashname: 879884287
			]
		]
	},
	{
		category_hashname:"LIPSTICK",
		ped_type: "both",
		models:
		[
			[

				{hash:0x99DE1FB5, hashname: "CLOTHING_ITEM_LIPSTICK_NONE"},                // dec unsign, hashname: 2581471157 dec sign, hashname: -1713496139
			],
			[
				{hash:0xF9536516, hashname: "CLOTHING_ITEM_LIPSTICK_000"},                // dec unsign, hashname: 4182992150 dec sign, hashname: -111975146
				{hash:0x141BEAAF, hashname: "CLOTHING_ITEM_LIPSTICK_000_TINT_001"},                // dec unsign, hashname: 337373871 dec sign, hashname: 337373871
				{hash:0xE6610F3A, hashname: "CLOTHING_ITEM_LIPSTICK_000_TINT_002"},                // dec unsign, hashname: 3865120570 dec sign, hashname: -429846726
				{hash:0x3819B2AA, hashname: "CLOTHING_ITEM_LIPSTICK_000_TINT_003"},                // dec unsign, hashname: 941208234 dec sign, hashname: 941208234
				{hash:0x09E3D63F, hashname: "CLOTHING_ITEM_LIPSTICK_000_TINT_004"},                // dec unsign, hashname: 165926463 dec sign, hashname: 165926463
			],
			[
				{hash:0xE705C07B, hashname: "CLOTHING_ITEM_LIPSTICK_001"},                // dec unsign, hashname: 3875913851 dec sign, hashname: -419053445
				{hash:0x9CCB9BDF, hashname: "CLOTHING_ITEM_LIPSTICK_001_TINT_001"},                // dec unsign, hashname: 2630589407 dec sign, hashname: -1664377889
				{hash:0xAE8C3F60, hashname: "CLOTHING_ITEM_LIPSTICK_001_TINT_002"},                // dec unsign, hashname: 2928426848 dec sign, hashname: -1366540448
				{hash:0x2CD1BBE9, hashname: "CLOTHING_ITEM_LIPSTICK_001_TINT_003"},                // dec unsign, hashname: 751942633 dec sign, hashname: 751942633
				{hash:0xFE81DF4A, hashname: "CLOTHING_ITEM_LIPSTICK_001_TINT_004"},                // dec unsign, hashname: 4269924170 dec sign, hashname: -25043126
			],
			[
				{hash:0x4DFD8E65, hashname: "CLOTHING_ITEM_LIPSTICK_002"},                // dec unsign, hashname: 1308462693 dec sign, hashname: 1308462693
				{hash:0x1011291C, hashname: "CLOTHING_ITEM_LIPSTICK_002_TINT_001"},                // dec unsign, hashname: 269560092 dec sign, hashname: 269560092
				{hash:0x00BB8A71, hashname: "CLOTHING_ITEM_LIPSTICK_002_TINT_002"},                // dec unsign, hashname: 12290673 dec sign, hashname: 12290673
				{hash:0x2BE0E0BB, hashname: "CLOTHING_ITEM_LIPSTICK_002_TINT_003"},                // dec unsign, hashname: 736157883 dec sign, hashname: 736157883
				{hash:0x1E164526, hashname: "CLOTHING_ITEM_LIPSTICK_002_TINT_004"},                // dec unsign, hashname: 504775974 dec sign, hashname: 504775974
			],
			[
				{hash:0x7C336AD0, hashname: "CLOTHING_ITEM_LIPSTICK_003"},                // dec unsign, hashname: 2083744464 dec sign, hashname: 2083744464
				{hash:0x1E8756C2, hashname: "CLOTHING_ITEM_LIPSTICK_003_TINT_001"},                // dec unsign, hashname: 512186050 dec sign, hashname: 512186050
				{hash:0x27D4695C, hashname: "CLOTHING_ITEM_LIPSTICK_003_TINT_002"},                // dec unsign, hashname: 668232028 dec sign, hashname: 668232028
				{hash:0xBA610E6F, hashname: "CLOTHING_ITEM_LIPSTICK_003_TINT_003"},                // dec unsign, hashname: 3126922863 dec sign, hashname: -1168044433
				{hash:0xC51323D3, hashname: "CLOTHING_ITEM_LIPSTICK_003_TINT_004"},                // dec unsign, hashname: 3306365907 dec sign, hashname: -988601389
			]
		]
	},
	{
		category_hashname:"EYEBROWS",
		ped_type: "male",
		models:
		[
			[	 
				{hash:0x047BCC03, hashname: "CLOTHING_ITEM_M_EYEBROWS_001"},                // dec unsign, hashname: 75222019 dec sign, hashname: 75222019
				{hash:0x371963BA, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_BLONDE"},                // dec unsign, hashname: 924410810 dec sign, hashname: 924410810
				{hash:0x35DDBE32, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_BROWN"},                // dec unsign, hashname: 903724594 dec sign, hashname: 903724594
				{hash:0x965C86AC, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_DARKEST_BROWN"},                // dec unsign, hashname: 2522646188 dec sign, hashname: -1772321108
				{hash:0x96B020BC, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_DARK_BLONDE"},                // dec unsign, hashname: 2528125116 dec sign, hashname: -1766842180
				{hash:0xF935E904, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_DARK_GINGER"},                // dec unsign, hashname: 4181059844 dec sign, hashname: -113907452
				{hash:0xD3CF0BD7, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_DARK_GREY"},                // dec unsign, hashname: 3553561559 dec sign, hashname: -741405737
				{hash:0x0B2F0B8F, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_GINGER"},                // dec unsign, hashname: 187632527 dec sign, hashname: 187632527
				{hash:0x724D820E, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_GREY"},                // dec unsign, hashname: 1917682190 dec sign, hashname: 1917682190
				{hash:0x2E8C0E3C, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_JET_BLACK"},                // dec unsign, hashname: 780930620 dec sign, hashname: 780930620
				{hash:0x4F38ECF2, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_LIGHT_BLONDE"},                // dec unsign, hashname: 1329130738 dec sign, hashname: 1329130738
				{hash:0x43B673D8, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_LIGHT_BROWN"},                // dec unsign, hashname: 1136030680 dec sign, hashname: 1136030680
				{hash:0xA5DD3E2C, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_LIGHT_GINGER"},                // dec unsign, hashname: 2782740012 dec sign, hashname: -1512227284
				{hash:0xC455D6C9, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_LIGHT_GREY"},                // dec unsign, hashname: 3293959881 dec sign, hashname: -1001007415
				{hash:0xBFE66A2B, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_MEDIUM_BROWN"},                // dec unsign, hashname: 3219548715 dec sign, hashname: -1075418581
				{hash:0x130EBDE4, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_SALT_PEPPER"},                // dec unsign, hashname: 319733220 dec sign, hashname: 319733220
				{hash:0xAF04DF96, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 2936332182 dec sign, hashname: -1358635114
				{hash:0x11F03A22, hashname: "CLOTHING_ITEM_M_EYEBROWS_001_UNCLE_GREY"},                // dec unsign, hashname: 300956194 dec sign, hashname: 300956194
			],
			[
				{hash:0x12C1688E, hashname: "CLOTHING_ITEM_M_EYEBROWS_002"},                // dec unsign, hashname: 314665102 dec sign, hashname: 314665102
				{hash:0x9CD02371, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_BLONDE"},                // dec unsign, hashname: 2630886257 dec sign, hashname: -1664081039
				{hash:0x46E2AACC, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_BROWN"},                // dec unsign, hashname: 1189259980 dec sign, hashname: 1189259980
				{hash:0xF3B86DE9, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_DARKEST_BROWN"},                // dec unsign, hashname: 4088950249 dec sign, hashname: -206017047
				{hash:0xB11E7247, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_DARK_BLONDE"},                // dec unsign, hashname: 2971562567 dec sign, hashname: -1323404729
				{hash:0xE6903ABB, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_DARK_GINGER"},                // dec unsign, hashname: 3868211899 dec sign, hashname: -426755397
				{hash:0x2F2AE8DE, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_DARK_GREY"},                // dec unsign, hashname: 791341278 dec sign, hashname: 791341278
				{hash:0x05E551B9, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_GINGER"},                // dec unsign, hashname: 98914745 dec sign, hashname: 98914745
				{hash:0xE0F51BC1, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_GREY"},                // dec unsign, hashname: 3774159809 dec sign, hashname: -520807487
				{hash:0x405B3774, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_JET_BLACK"},                // dec unsign, hashname: 1079719796 dec sign, hashname: 1079719796
				{hash:0x260F684B, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_LIGHT_BLONDE"},                // dec unsign, hashname: 638543947 dec sign, hashname: 638543947
				{hash:0x627FAA1B, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_LIGHT_BROWN"},                // dec unsign, hashname: 1652533787 dec sign, hashname: 1652533787
				{hash:0x291AE754, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_LIGHT_GINGER"},                // dec unsign, hashname: 689629012 dec sign, hashname: 689629012
				{hash:0x9E3580D6, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_LIGHT_GREY"},                // dec unsign, hashname: 2654306518 dec sign, hashname: -1640660778
				{hash:0xD003D6BF, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_MEDIUM_BROWN"},                // dec unsign, hashname: 3489912511 dec sign, hashname: -805054785
				{hash:0xCD54867B, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_SALT_PEPPER"},                // dec unsign, hashname: 3444868731 dec sign, hashname: -850098565
				{hash:0x7667AD2D, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1986506029 dec sign, hashname: 1986506029
				{hash:0xBF7F0147, hashname: "CLOTHING_ITEM_M_EYEBROWS_002_UNCLE_GREY"},                // dec unsign, hashname: 3212771655 dec sign, hashname: -1082195641
			],
			[
				{hash:0xE0D404B4, hashname: "CLOTHING_ITEM_M_EYEBROWS_003"},                // dec unsign, hashname: 3771991220 dec sign, hashname: -522976076
				{hash:0x982B19E2, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_BLONDE"},                // dec unsign, hashname: 2552961506 dec sign, hashname: -1742005790
				{hash:0x19ABF737, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_BROWN"},                // dec unsign, hashname: 430700343 dec sign, hashname: 430700343
				{hash:0x7A79DD2C, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_DARKEST_BROWN"},                // dec unsign, hashname: 2054806828 dec sign, hashname: 2054806828
				{hash:0x18F578B6, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_DARK_BLONDE"},                // dec unsign, hashname: 418740406 dec sign, hashname: 418740406
				{hash:0xF95F0913, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_DARK_GINGER"},                // dec unsign, hashname: 4183755027 dec sign, hashname: -111212269
				{hash:0xA46F1841, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_DARK_GREY"},                // dec unsign, hashname: 2758744129 dec sign, hashname: -1536223167
				{hash:0xFC23EABF, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_GINGER"},                // dec unsign, hashname: 4230212287 dec sign, hashname: -64755009
				{hash:0xB14F6DF8, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_GREY"},                // dec unsign, hashname: 2974772728 dec sign, hashname: -1320194568
				{hash:0x51C0911C, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_JET_BLACK"},                // dec unsign, hashname: 1371574556 dec sign, hashname: 1371574556
				{hash:0x74CFFEDC, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_LIGHT_BLONDE"},                // dec unsign, hashname: 1959788252 dec sign, hashname: 1959788252
				{hash:0xFE449229, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_LIGHT_BROWN"},                // dec unsign, hashname: 4265906729 dec sign, hashname: -29060567
				{hash:0xA7F56125, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_LIGHT_GINGER"},                // dec unsign, hashname: 2817876261 dec sign, hashname: -1477091035
				{hash:0xE9ED6B6A, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_LIGHT_GREY"},                // dec unsign, hashname: 3924650858 dec sign, hashname: -370316438
				{hash:0xC63614BE, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_MEDIUM_BROWN"},                // dec unsign, hashname: 3325433022 dec sign, hashname: -969534274
				{hash:0x14BE2037, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_SALT_PEPPER"},                // dec unsign, hashname: 348004407 dec sign, hashname: 348004407
				{hash:0xCE2C35B4, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 3459003828 dec sign, hashname: -835963468
				{hash:0x903D71F6, hashname: "CLOTHING_ITEM_M_EYEBROWS_003_UNCLE_GREY"},                // dec unsign, hashname: 2419945974 dec sign, hashname: -1875021322
			],
			[
				{hash:0x615185AD, hashname: "CLOTHING_ITEM_M_EYEBROWS_004"},                // dec unsign, hashname: 1632732589 dec sign, hashname: 1632732589
				{hash:0xFD025A82, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_BLONDE"},                // dec unsign, hashname: 4244789890 dec sign, hashname: -50177406
				{hash:0x2B1EC8AF, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_BROWN"},                // dec unsign, hashname: 723437743 dec sign, hashname: 723437743
				{hash:0xB60AF14B, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_DARKEST_BROWN"},                // dec unsign, hashname: 3054170443 dec sign, hashname: -1240796853
				{hash:0x99352BB6, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_DARK_BLONDE"},                // dec unsign, hashname: 2570398646 dec sign, hashname: -1724568650
				{hash:0x9FD4B500, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_DARK_GINGER"},                // dec unsign, hashname: 2681517312 dec sign, hashname: -1613449984
				{hash:0xEBC43342, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_DARK_GREY"},                // dec unsign, hashname: 3955503938 dec sign, hashname: -339463358
				{hash:0xBB8D0A0F, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_GINGER"},                // dec unsign, hashname: 3146582543 dec sign, hashname: -1148384753
				{hash:0x1F0A5E73, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_GREY"},                // dec unsign, hashname: 520773235 dec sign, hashname: 520773235
				{hash:0xA6B6AA4E, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_JET_BLACK"},                // dec unsign, hashname: 2796989006 dec sign, hashname: -1497978290
				{hash:0x9B9C15D8, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_LIGHT_BLONDE"},                // dec unsign, hashname: 2610697688 dec sign, hashname: -1684269608
				{hash:0x18084918, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_LIGHT_BROWN"},                // dec unsign, hashname: 403196184 dec sign, hashname: 403196184
				{hash:0x2F0DF69D, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_LIGHT_GINGER"},                // dec unsign, hashname: 789444253 dec sign, hashname: 789444253
				{hash:0x393F457F, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_LIGHT_GREY"},                // dec unsign, hashname: 960447871 dec sign, hashname: 960447871
				{hash:0x70676837, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_MEDIUM_BROWN"},                // dec unsign, hashname: 1885825079 dec sign, hashname: 1885825079
				{hash:0x1DF841DB, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_SALT_PEPPER"},                // dec unsign, hashname: 502809051 dec sign, hashname: 502809051
				{hash:0x6E8D9D65, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1854774629 dec sign, hashname: 1854774629
				{hash:0xE011D833, hashname: "CLOTHING_ITEM_M_EYEBROWS_004_UNCLE_GREY"},                // dec unsign, hashname: 3759265843 dec sign, hashname: -535701453
			],
			[
				{hash:0x6F0C2122, hashname: "CLOTHING_ITEM_M_EYEBROWS_005"},                // dec unsign, hashname: 1863065890 dec sign, hashname: 1863065890
				{hash:0x48E76F46, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_BLONDE"},                // dec unsign, hashname: 1223126854 dec sign, hashname: 1223126854
				{hash:0xA62276FB, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_BROWN"},                // dec unsign, hashname: 2787276539 dec sign, hashname: -1507690757
				{hash:0xBBE29A6C, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_DARKEST_BROWN"},                // dec unsign, hashname: 3152190060 dec sign, hashname: -1142777236
				{hash:0x07F8D766, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_DARK_BLONDE"},                // dec unsign, hashname: 133748582 dec sign, hashname: 133748582
				{hash:0x62DFB8F9, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_DARK_GINGER"},                // dec unsign, hashname: 1658829049 dec sign, hashname: 1658829049
				{hash:0x2F037BEB, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_DARK_GREY"},                // dec unsign, hashname: 788757483 dec sign, hashname: 788757483
				{hash:0xC8A21CCA, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_GINGER"},                // dec unsign, hashname: 3366067402 dec sign, hashname: -928899894
				{hash:0xFC052CF2, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_GREY"},                // dec unsign, hashname: 4228197618 dec sign, hashname: -66769678
				{hash:0x5C149DEF, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_JET_BLACK"},                // dec unsign, hashname: 1544855023 dec sign, hashname: 1544855023
				{hash:0x1AA32DFA, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_LIGHT_BLONDE"},                // dec unsign, hashname: 446901754 dec sign, hashname: 446901754
				{hash:0xDDE61F27, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_LIGHT_BROWN"},                // dec unsign, hashname: 3722845991 dec sign, hashname: -572121305
				{hash:0x97F01C46, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_LIGHT_GINGER"},                // dec unsign, hashname: 2549095494 dec sign, hashname: -1745871802
				{hash:0xF5055847, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_LIGHT_GREY"},                // dec unsign, hashname: 4110768199 dec sign, hashname: -184199097
				{hash:0x939AD938, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_MEDIUM_BROWN"},                // dec unsign, hashname: 2476398904 dec sign, hashname: -1818568392
				{hash:0x2E0FDACE, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_SALT_PEPPER"},                // dec unsign, hashname: 772790990 dec sign, hashname: 772790990
				{hash:0x51A7A880, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1369942144 dec sign, hashname: 1369942144
				{hash:0x8127A8E6, hashname: "CLOTHING_ITEM_M_EYEBROWS_005_UNCLE_GREY"},                // dec unsign, hashname: 2166860006 dec sign, hashname: -2128107290
			],
			[
				{hash:0x19F8AAC9, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_BLONDE"},                // dec unsign, hashname: 435727049 dec sign, hashname: 435727049
				{hash:0x5489AA00, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_BROWN"},                // dec unsign, hashname: 1418308096 dec sign, hashname: 1418308096
				{hash:0xDFC719BE, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_DARKEST_BROWN"},                // dec unsign, hashname: 3754367422 dec sign, hashname: -540599874
				{hash:0x7FD1B364, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_DARK_BLONDE"},                // dec unsign, hashname: 2144449380 dec sign, hashname: 2144449380
				{hash:0x77A3FA7D, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_DARK_GINGER"},                // dec unsign, hashname: 2007235197 dec sign, hashname: 2007235197
				{hash:0xE9BC0A30, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_DARK_GREY"},                // dec unsign, hashname: 3921414704 dec sign, hashname: -373552592
				{hash:0x3FA6A96A, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_GINGER"},                // dec unsign, hashname: 1067886954 dec sign, hashname: 1067886954
				{hash:0x7BD48E78, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_GREY"},                // dec unsign, hashname: 2077527672 dec sign, hashname: 2077527672
				{hash:0x9B617C94, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_JET_BLACK"},                // dec unsign, hashname: 2606857364 dec sign, hashname: -1688109932
				{hash:0x81E1FF90, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_LIGHT_BLONDE"},                // dec unsign, hashname: 2179071888 dec sign, hashname: -2115895408
				{hash:0xE2A03605, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_LIGHT_BROWN"},                // dec unsign, hashname: 3802150405 dec sign, hashname: -492816891
				{hash:0x92D4BCC6, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_LIGHT_GINGER"},                // dec unsign, hashname: 2463415494 dec sign, hashname: -1831551802
				{hash:0x681E7D2F, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_LIGHT_GREY"},                // dec unsign, hashname: 1746828591 dec sign, hashname: 1746828591
				{hash:0x982FC4E2, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_MEDIUM_BROWN"},                // dec unsign, hashname: 2553267426 dec sign, hashname: -1741699870
				{hash:0xF4C9A104, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_SALT_PEPPER"},                // dec unsign, hashname: 4106854660 dec sign, hashname: -188112636
				{hash:0x755076EC, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1968207596 dec sign, hashname: 1968207596
				{hash:0x35BC180A, hashname: "CLOTHING_ITEM_M_EYEBROWS_006_UNCLE_GREY"},                // dec unsign, hashname: 901519370 dec sign, hashname: 901519370
			],
			[
				{hash:0x5B827A0F, hashname: "CLOTHING_ITEM_M_EYEBROWS_007"},                // dec unsign, hashname: 1535277583 dec sign, hashname: 1535277583
				{hash:0xE27A1B5F, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_BLONDE"},                // dec unsign, hashname: 3799653215 dec sign, hashname: -495314081
				{hash:0x8EF45D25, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_BROWN"},                // dec unsign, hashname: 2398379301 dec sign, hashname: -1896587995
				{hash:0x7E0098B5, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_DARKEST_BROWN"},                // dec unsign, hashname: 2113968309 dec sign, hashname: 2113968309
				{hash:0x991B7810, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_DARK_BLONDE"},                // dec unsign, hashname: 2568714256 dec sign, hashname: -1726253040
				{hash:0xE37363E6, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_DARK_GINGER"},                // dec unsign, hashname: 3815990246 dec sign, hashname: -478977050
				{hash:0x1CE16D10, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_DARK_GREY"},                // dec unsign, hashname: 484535568 dec sign, hashname: 484535568
				{hash:0xC57575CC, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_GINGER"},                // dec unsign, hashname: 3312809420 dec sign, hashname: -982157876
				{hash:0xD725A046, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_GREY"},                // dec unsign, hashname: 3609567302 dec sign, hashname: -685399994
				{hash:0xCE70A380, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_JET_BLACK"},                // dec unsign, hashname: 3463488384 dec sign, hashname: -831478912
				{hash:0x9D94343E, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_LIGHT_BLONDE"},                // dec unsign, hashname: 2643735614 dec sign, hashname: -1651231682
				{hash:0x15FF4D89, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_LIGHT_BROWN"},                // dec unsign, hashname: 369053065 dec sign, hashname: 369053065
				{hash:0x84B92435, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_LIGHT_GINGER"},                // dec unsign, hashname: 2226725941 dec sign, hashname: -2068241355
				{hash:0xE157B535, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_LIGHT_GREY"},                // dec unsign, hashname: 3780621621 dec sign, hashname: -514345675
				{hash:0x6BCBF4EC, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_MEDIUM_BROWN"},                // dec unsign, hashname: 1808528620 dec sign, hashname: 1808528620
				{hash:0x6C916A5B, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_SALT_PEPPER"},                // dec unsign, hashname: 1821469275 dec sign, hashname: 1821469275
				{hash:0x4A545980, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1247041920 dec sign, hashname: 1247041920
				{hash:0x5A727CE1, hashname: "CLOTHING_ITEM_M_EYEBROWS_007_UNCLE_GREY"},                // dec unsign, hashname: 1517452513 dec sign, hashname: 1517452513
			],
			[
				{hash:0x84794C00, hashname: "CLOTHING_ITEM_M_EYEBROWS_008"},                // dec unsign, hashname: 2222541824 dec sign, hashname: -2072425472
				{hash:0x083567C5, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_BLONDE"},                // dec unsign, hashname: 137717701 dec sign, hashname: 137717701
				{hash:0x12F253EE, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_BROWN"},                // dec unsign, hashname: 317871086 dec sign, hashname: 317871086
				{hash:0x321F05D6, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_DARKEST_BROWN"},                // dec unsign, hashname: 840893910 dec sign, hashname: 840893910
				{hash:0x9658F43B, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_DARK_BLONDE"},                // dec unsign, hashname: 2522412091 dec sign, hashname: -1772555205
				{hash:0x1BC48BA6, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_DARK_GINGER"},                // dec unsign, hashname: 465865638 dec sign, hashname: 465865638
				{hash:0x6336A33F, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_DARK_GREY"},                // dec unsign, hashname: 1664525119 dec sign, hashname: 1664525119
				{hash:0x2FBCFF3B, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_GINGER"},                // dec unsign, hashname: 800915259 dec sign, hashname: 800915259
				{hash:0x4AAEFB82, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_GREY"},                // dec unsign, hashname: 1252981634 dec sign, hashname: 1252981634
				{hash:0x0B1F588C, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_JET_BLACK"},                // dec unsign, hashname: 186603660 dec sign, hashname: 186603660
				{hash:0x8427AD95, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_LIGHT_BLONDE"},                // dec unsign, hashname: 2217192853 dec sign, hashname: -2077774443
				{hash:0x81524B4E, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_LIGHT_BROWN"},                // dec unsign, hashname: 2169654094 dec sign, hashname: -2125313202
				{hash:0xEC470154, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_LIGHT_GINGER"},                // dec unsign, hashname: 3964076372 dec sign, hashname: -330890924
				{hash:0x58241083, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_LIGHT_GREY"},                // dec unsign, hashname: 1478758531 dec sign, hashname: 1478758531
				{hash:0x61214EEB, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_MEDIUM_BROWN"},                // dec unsign, hashname: 1629572843 dec sign, hashname: 1629572843
				{hash:0x2A11D4BB, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_SALT_PEPPER"},                // dec unsign, hashname: 705811643 dec sign, hashname: 705811643
				{hash:0x9B304BAF, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 2603633583 dec sign, hashname: -1691333713
				{hash:0x805DB6F4, hashname: "CLOTHING_ITEM_M_EYEBROWS_008_UNCLE_GREY"},                // dec unsign, hashname: 2153625332 dec sign, hashname: -2141341964
			],
			[
				{hash:0x9640EF8F, hashname: "CLOTHING_ITEM_M_EYEBROWS_009"},                // dec unsign, hashname: 2520838031 dec sign, hashname: -1774129265
				{hash:0xF2454283, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_BLONDE"},                // dec unsign, hashname: 4064625283 dec sign, hashname: -230342013
				{hash:0x235183B6, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_BROWN"},                // dec unsign, hashname: 592544694 dec sign, hashname: 592544694
				{hash:0x3D751E7A, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_DARKEST_BROWN"},                // dec unsign, hashname: 1031085690 dec sign, hashname: 1031085690
				{hash:0xC7D5304C, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_DARK_BLONDE"},                // dec unsign, hashname: 3352637516 dec sign, hashname: -942329780
				{hash:0xC88C4AF9, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_DARK_GINGER"},                // dec unsign, hashname: 3364637433 dec sign, hashname: -930329863
				{hash:0xEF0900AC, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_DARK_GREY"},                // dec unsign, hashname: 4010344620 dec sign, hashname: -284622676
				{hash:0x751D2D86, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_GINGER"},                // dec unsign, hashname: 1964846470 dec sign, hashname: 1964846470
				{hash:0x0381E422, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_GREY"},                // dec unsign, hashname: 58844194 dec sign, hashname: 58844194
				{hash:0x4E9F8C76, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_JET_BLACK"},                // dec unsign, hashname: 1319079030 dec sign, hashname: 1319079030
				{hash:0xFF63AC90, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_LIGHT_BLONDE"},                // dec unsign, hashname: 4284722320 dec sign, hashname: -10244976
				{hash:0x8469E2F6, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_LIGHT_BROWN"},                // dec unsign, hashname: 2221531894 dec sign, hashname: -2073435402
				{hash:0x288A8E70, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_LIGHT_GINGER"},                // dec unsign, hashname: 680169072 dec sign, hashname: 680169072
				{hash:0x7EE4C3F9, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_LIGHT_GREY"},                // dec unsign, hashname: 2128921593 dec sign, hashname: 2128921593
				{hash:0x0A27DA3B, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_MEDIUM_BROWN"},                // dec unsign, hashname: 170383931 dec sign, hashname: 170383931
				{hash:0x926ED6F0, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_SALT_PEPPER"},                // dec unsign, hashname: 2456737520 dec sign, hashname: -1838229776
				{hash:0x44E1EC39, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1155656761 dec sign, hashname: 1155656761
				{hash:0xDC764944, hashname: "CLOTHING_ITEM_M_EYEBROWS_009_UNCLE_GREY"},                // dec unsign, hashname: 3698739524 dec sign, hashname: -596227772
			],
			[
				{hash:0x6009FB72, hashname: "CLOTHING_ITEM_M_EYEBROWS_010"},                // dec unsign, hashname: 1611266930 dec sign, hashname: 1611266930
				{hash:0x993994EA, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_BLONDE"},                // dec unsign, hashname: 2570687722 dec sign, hashname: -1724279574
				{hash:0xA8A6E0B9, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_BROWN"},                // dec unsign, hashname: 2829508793 dec sign, hashname: -1465458503
				{hash:0xA957F644, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_DARKEST_BROWN"},                // dec unsign, hashname: 2841114180 dec sign, hashname: -1453853116
				{hash:0xED1027F0, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_DARK_BLONDE"},                // dec unsign, hashname: 3977258992 dec sign, hashname: -317708304
				{hash:0x2FFB9D5E, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_DARK_GINGER"},                // dec unsign, hashname: 805018974 dec sign, hashname: 805018974
				{hash:0x62B58875, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_DARK_GREY"},                // dec unsign, hashname: 1656064117 dec sign, hashname: 1656064117
				{hash:0x28FF4A4B, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_GINGER"},                // dec unsign, hashname: 687819339 dec sign, hashname: 687819339
				{hash:0xE55BED2E, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_GREY"},                // dec unsign, hashname: 3848006958 dec sign, hashname: -446960338
				{hash:0xBB460D11, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_JET_BLACK"},                // dec unsign, hashname: 3141930257 dec sign, hashname: -1153037039
				{hash:0x0663DD36, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_LIGHT_BLONDE"},                // dec unsign, hashname: 107207990 dec sign, hashname: 107207990
				{hash:0xD512746E, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_LIGHT_BROWN"},                // dec unsign, hashname: 3574756462 dec sign, hashname: -720210834
				{hash:0xA1A7E25E, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_LIGHT_GINGER"},                // dec unsign, hashname: 2712134238 dec sign, hashname: -1582833058
				{hash:0x60E7694E, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_LIGHT_GREY"},                // dec unsign, hashname: 1625778510 dec sign, hashname: 1625778510
				{hash:0x3570BA6B, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_MEDIUM_BROWN"},                // dec unsign, hashname: 896580203 dec sign, hashname: 896580203
				{hash:0x7E0813B5, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_SALT_PEPPER"},                // dec unsign, hashname: 2114458549 dec sign, hashname: 2114458549
				{hash:0x6C62DF81, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1818419073 dec sign, hashname: 1818419073
				{hash:0x32A2C820, hashname: "CLOTHING_ITEM_M_EYEBROWS_010_UNCLE_GREY"},                // dec unsign, hashname: 849528864 dec sign, hashname: 849528864
			],
			[
				{hash:0x45C6C6EC, hashname: "CLOTHING_ITEM_M_EYEBROWS_011"},                // dec unsign, hashname: 1170654956 dec sign, hashname: 1170654956
				{hash:0x34E22EC4, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_BLONDE"},                // dec unsign, hashname: 887238340 dec sign, hashname: 887238340
				{hash:0xF9664020, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_BROWN"},                // dec unsign, hashname: 4184227872 dec sign, hashname: -110739424
				{hash:0x7B5AC8B2, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_DARKEST_BROWN"},                // dec unsign, hashname: 2069547186 dec sign, hashname: 2069547186
				{hash:0x40FD6540, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_DARK_BLONDE"},                // dec unsign, hashname: 1090348352 dec sign, hashname: 1090348352
				{hash:0xB0824F97, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_DARK_GINGER"},                // dec unsign, hashname: 2961330071 dec sign, hashname: -1333637225
				{hash:0xE7D39D79, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_DARK_GREY"},                // dec unsign, hashname: 3889405305 dec sign, hashname: -405561991
				{hash:0x1F5B7F42, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_GINGER"},                // dec unsign, hashname: 526090050 dec sign, hashname: 526090050
				{hash:0xFC72D8AE, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_GREY"},                // dec unsign, hashname: 4235385006 dec sign, hashname: -59582290
				{hash:0x81B6DABC, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_JET_BLACK"},                // dec unsign, hashname: 2176244412 dec sign, hashname: -2118722884
				{hash:0x4EC44767, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_LIGHT_BLONDE"},                // dec unsign, hashname: 1321486183 dec sign, hashname: 1321486183
				{hash:0x624215F3, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_LIGHT_BROWN"},                // dec unsign, hashname: 1648498163 dec sign, hashname: 1648498163
				{hash:0x661706DD, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_LIGHT_GINGER"},                // dec unsign, hashname: 1712785117 dec sign, hashname: 1712785117
				{hash:0xB10848C0, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_LIGHT_GREY"},                // dec unsign, hashname: 2970110144 dec sign, hashname: -1324857152
				{hash:0x4D9AADD7, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_MEDIUM_BROWN"},                // dec unsign, hashname: 1301982679 dec sign, hashname: 1301982679
				{hash:0xDA976EF7, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_SALT_PEPPER"},                // dec unsign, hashname: 3667357431 dec sign, hashname: -627609865
				{hash:0x7E352FF2, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 2117414898 dec sign, hashname: 2117414898
				{hash:0xB3D00C51, hashname: "CLOTHING_ITEM_M_EYEBROWS_011_UNCLE_GREY"},                // dec unsign, hashname: 3016756305 dec sign, hashname: -1278210991
			],
			[
				{hash:0x10CA5CF0, hashname: "CLOTHING_ITEM_M_EYEBROWS_012"},                // dec unsign, hashname: 281697520 dec sign, hashname: 281697520
				{hash:0x9334C9C2, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_BLONDE"},                // dec unsign, hashname: 2469710274 dec sign, hashname: -1825257022
				{hash:0x1510854F, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_BROWN"},                // dec unsign, hashname: 353404239 dec sign, hashname: 353404239
				{hash:0xB42439EA, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_DARKEST_BROWN"},                // dec unsign, hashname: 3022273002 dec sign, hashname: -1272694294
				{hash:0xC866362A, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_DARK_BLONDE"},                // dec unsign, hashname: 3362141738 dec sign, hashname: -932825558
				{hash:0x89DB320C, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_DARK_GINGER"},                // dec unsign, hashname: 2312843788 dec sign, hashname: -1982123508
				{hash:0x2022ABE5, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_DARK_GREY"},                // dec unsign, hashname: 539143141 dec sign, hashname: 539143141
				{hash:0xC127A3FE, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_GINGER"},                // dec unsign, hashname: 3240600574 dec sign, hashname: -1054366722
				{hash:0xCD34D27E, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_GREY"},                // dec unsign, hashname: 3442791038 dec sign, hashname: -852176258
				{hash:0x360765A1, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_JET_BLACK"},                // dec unsign, hashname: 906454433 dec sign, hashname: 906454433
				{hash:0x58358CBB, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_LIGHT_BLONDE"},                // dec unsign, hashname: 1479904443 dec sign, hashname: 1479904443
				{hash:0xF0BA8250, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_LIGHT_BROWN"},                // dec unsign, hashname: 4038754896 dec sign, hashname: -256212400
				{hash:0x4FB4AD7B, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_LIGHT_GINGER"},                // dec unsign, hashname: 1337240955 dec sign, hashname: 1337240955
				{hash:0xAF414727, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_LIGHT_GREY"},                // dec unsign, hashname: 2940290855 dec sign, hashname: -1354676441
				{hash:0x13D9D5AA, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_MEDIUM_BROWN"},                // dec unsign, hashname: 333043114 dec sign, hashname: 333043114
				{hash:0xE3D7D82A, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_SALT_PEPPER"},                // dec unsign, hashname: 3822573610 dec sign, hashname: -472393686
				{hash:0x54F7240D, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1425482765 dec sign, hashname: 1425482765
				{hash:0xB0F829C4, hashname: "CLOTHING_ITEM_M_EYEBROWS_012_UNCLE_GREY"},                // dec unsign, hashname: 2969053636 dec sign, hashname: -1325913660
			],
			[
				{hash:0xBE8C3875, hashname: "CLOTHING_ITEM_M_EYEBROWS_013"},                // dec unsign, hashname: 3196860533 dec sign, hashname: -1098106763
				{hash:0x478FB495, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_BLONDE"},                // dec unsign, hashname: 1200600213 dec sign, hashname: 1200600213
				{hash:0x14C0EC49, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_BROWN"},                // dec unsign, hashname: 348187721 dec sign, hashname: 348187721
				{hash:0x50F1EFD3, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_DARKEST_BROWN"},                // dec unsign, hashname: 1358032851 dec sign, hashname: 1358032851
				{hash:0x4BE6AEBC, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_DARK_BLONDE"},                // dec unsign, hashname: 1273409212 dec sign, hashname: 1273409212
				{hash:0xB537CA6F, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_DARK_GINGER"},                // dec unsign, hashname: 3040332399 dec sign, hashname: -1254634897
				{hash:0x4C8C2D42, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_DARK_GREY"},                // dec unsign, hashname: 1284255042 dec sign, hashname: 1284255042
				{hash:0x08354A1E, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_GINGER"},                // dec unsign, hashname: 137710110 dec sign, hashname: 137710110
				{hash:0x00423073, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_GREY"},                // dec unsign, hashname: 4337779 dec sign, hashname: 4337779
				{hash:0x88D2E5B7, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_JET_BLACK"},                // dec unsign, hashname: 2295522743 dec sign, hashname: -1999444553
				{hash:0x6F7A83E4, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_LIGHT_BLONDE"},                // dec unsign, hashname: 1870300132 dec sign, hashname: 1870300132
				{hash:0xDD14292F, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_LIGHT_BROWN"},                // dec unsign, hashname: 3709085999 dec sign, hashname: -585881297
				{hash:0xF3630686, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_LIGHT_GINGER"},                // dec unsign, hashname: 4083353222 dec sign, hashname: -211614074
				{hash:0xCC6B690C, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_LIGHT_GREY"},                // dec unsign, hashname: 3429591308 dec sign, hashname: -865375988
				{hash:0x1111AEC5, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_MEDIUM_BROWN"},                // dec unsign, hashname: 286371525 dec sign, hashname: 286371525
				{hash:0x9406AF11, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_SALT_PEPPER"},                // dec unsign, hashname: 2483466001 dec sign, hashname: -1811501295
				{hash:0x0C2AE365, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 204137317 dec sign, hashname: 204137317
				{hash:0xDB89EA6C, hashname: "CLOTHING_ITEM_M_EYEBROWS_013_UNCLE_GREY"},                // dec unsign, hashname: 3683248748 dec sign, hashname: -611718548
			],
			[
				{hash:0xED3795CB, hashname: "CLOTHING_ITEM_M_EYEBROWS_014"},                // dec unsign, hashname: 3979843019 dec sign, hashname: -315124277
				{hash:0xC34A5EAF, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_BLONDE"},                // dec unsign, hashname: 3276431023 dec sign, hashname: -1018536273
				{hash:0x374BB75D, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_BROWN"},                // dec unsign, hashname: 927709021 dec sign, hashname: 927709021
				{hash:0x88E58236, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_DARKEST_BROWN"},                // dec unsign, hashname: 2296742454 dec sign, hashname: -1998224842
				{hash:0x4A31E60A, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_DARK_BLONDE"},                // dec unsign, hashname: 1244784138 dec sign, hashname: 1244784138
				{hash:0xE29B0B49, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_DARK_GINGER"},                // dec unsign, hashname: 3801811785 dec sign, hashname: -493155511
				{hash:0x91B0C9D4, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_DARK_GREY"},                // dec unsign, hashname: 2444282324 dec sign, hashname: -1850684972
				{hash:0xC87B1061, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_GINGER"},                // dec unsign, hashname: 3363508321 dec sign, hashname: -931458975
				{hash:0xA1BDF15A, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_GREY"},                // dec unsign, hashname: 2713579866 dec sign, hashname: -1581387430
				{hash:0x6A52F981, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_JET_BLACK"},                // dec unsign, hashname: 1783822721 dec sign, hashname: 1783822721
				{hash:0xE58FFE54, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_LIGHT_BLONDE"},                // dec unsign, hashname: 3851419220 dec sign, hashname: -443548076
				{hash:0xBD19C5D7, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_LIGHT_BROWN"},                // dec unsign, hashname: 3172582871 dec sign, hashname: -1122384425
				{hash:0xFE2BA654, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_LIGHT_GINGER"},                // dec unsign, hashname: 4264273492 dec sign, hashname: -30693804
				{hash:0x8ACB73EA, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_LIGHT_GREY"},                // dec unsign, hashname: 2328589290 dec sign, hashname: -1966378006
				{hash:0xA2D8D3C8, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_MEDIUM_BROWN"},                // dec unsign, hashname: 2732118984 dec sign, hashname: -1562848312
				{hash:0x5DFD2423, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_SALT_PEPPER"},                // dec unsign, hashname: 1576870947 dec sign, hashname: 1576870947
				{hash:0x4B8DDB27, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 1267587879 dec sign, hashname: 1267587879
				{hash:0x9E61581E, hashname: "CLOTHING_ITEM_M_EYEBROWS_014_UNCLE_GREY"},                // dec unsign, hashname: 2657179678 dec sign, hashname: -1637787618
			],
			[
				{hash:0x1B01715E, hashname: "CLOTHING_ITEM_M_EYEBROWS_015"},                // dec unsign, hashname: 453079390 dec sign, hashname: 453079390
				{hash:0x16C65E16, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_BLONDE"},                // dec unsign, hashname: 382098966 dec sign, hashname: 382098966
				{hash:0xEB7A15C2, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_BROWN"},                // dec unsign, hashname: 3950646722 dec sign, hashname: -344320574
				{hash:0x8503F2FB, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_DARKEST_BROWN"},                // dec unsign, hashname: 2231628539 dec sign, hashname: -2063338757
				{hash:0x873BDC70, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_DARK_BLONDE"},                // dec unsign, hashname: 2268847216 dec sign, hashname: -2026120080
				{hash:0x5D059C9F, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_DARK_GINGER"},                // dec unsign, hashname: 1560648863 dec sign, hashname: 1560648863
				{hash:0x419D7FF1, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_DARK_GREY"},                // dec unsign, hashname: 1100840945 dec sign, hashname: 1100840945
				{hash:0xCCD4C853, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_GINGER"},                // dec unsign, hashname: 3436496979 dec sign, hashname: -858470317
				{hash:0xA0313B69, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_GREY"},                // dec unsign, hashname: 2687581033 dec sign, hashname: -1607386263
				{hash:0xF8F58144, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_JET_BLACK"},                // dec unsign, hashname: 4176838980 dec sign, hashname: -118128316
				{hash:0x5F85754A, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_LIGHT_BLONDE"},                // dec unsign, hashname: 1602581834 dec sign, hashname: 1602581834
				{hash:0x81A0A3D2, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_LIGHT_BROWN"},                // dec unsign, hashname: 2174788562 dec sign, hashname: -2120178734
				{hash:0x272B095B, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_LIGHT_GINGER"},                // dec unsign, hashname: 657131867 dec sign, hashname: 657131867
				{hash:0x6D0A3CA8, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_LIGHT_GREY"},                // dec unsign, hashname: 1829387432 dec sign, hashname: 1829387432
				{hash:0x4F46E95C, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_MEDIUM_BROWN"},                // dec unsign, hashname: 1330047324 dec sign, hashname: 1330047324
				{hash:0xC1D2C833, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_SALT_PEPPER"},                // dec unsign, hashname: 3251816499 dec sign, hashname: -1043150797
				{hash:0x2FFCCC74, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 805096564 dec sign, hashname: 805096564
				{hash:0x39204BB7, hashname: "CLOTHING_ITEM_M_EYEBROWS_015_UNCLE_GREY"},                // dec unsign, hashname: 958417847 dec sign, hashname: 958417847
			],
			[
				{hash:0xC988CE6E, hashname: "CLOTHING_ITEM_M_EYEBROWS_016"},                // dec unsign, hashname: 3381186158 dec sign, hashname: -913781138
				{hash:0x252B5113, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_BLONDE"},                // dec unsign, hashname: 623595795 dec sign, hashname: 623595795
				{hash:0x76D5BA14, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_BROWN"},                // dec unsign, hashname: 1993718292 dec sign, hashname: 1993718292
				{hash:0x874E62A6, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_DARKEST_BROWN"},                // dec unsign, hashname: 2270061222 dec sign, hashname: -2024906074
				{hash:0x3E8B75A3, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_DARK_BLONDE"},                // dec unsign, hashname: 1049327011 dec sign, hashname: 1049327011
				{hash:0xD76330A6, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_DARK_GINGER"},                // dec unsign, hashname: 3613601958 dec sign, hashname: -681365338
				{hash:0x47A41BC2, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_DARK_GREY"},                // dec unsign, hashname: 1201937346 dec sign, hashname: 1201937346
				{hash:0xDC17A10B, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_GINGER"},                // dec unsign, hashname: 3692536075 dec sign, hashname: -602431221
				{hash:0xAB39E566, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_GREY"},                // dec unsign, hashname: 2872698214 dec sign, hashname: -1422269082
				{hash:0xB00564E4, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_JET_BLACK"},                // dec unsign, hashname: 2953143524 dec sign, hashname: -1341823772
				{hash:0xF1EC6388, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_LIGHT_BLONDE"},                // dec unsign, hashname: 4058801032 dec sign, hashname: -236166264
				{hash:0x7DDC7CBA, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_LIGHT_BROWN"},                // dec unsign, hashname: 2111601850 dec sign, hashname: 2111601850
				{hash:0x180D3954, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_LIGHT_GINGER"},                // dec unsign, hashname: 403519828 dec sign, hashname: 403519828
				{hash:0x9C3E4368, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_LIGHT_GREY"},                // dec unsign, hashname: 2621326184 dec sign, hashname: -1673641112
				{hash:0x8886A8A1, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_MEDIUM_BROWN"},                // dec unsign, hashname: 2290526369 dec sign, hashname: -2004440927
				{hash:0xA6B2B3C6, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_SALT_PEPPER"},                // dec unsign, hashname: 2796729286 dec sign, hashname: -1498238010
				{hash:0xD0C2F9F1, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_STRAWBERRY_BLONDE"},                // dec unsign, hashname: 3502438897 dec sign, hashname: -792528399
				{hash:0xDC949462, hashname: "CLOTHING_ITEM_M_EYEBROWS_016_UNCLE_GREY"},                // dec unsign, hashname: 3700724834 dec sign, hashname: -594242462

			]
		]
	},
]


var currentTextureSettings = textureTypes.male;
var textureId = -1;
var overlay_opacity = 1.0;
var is_overlay_change_active = false;
let ped;
let skinTone;

const overlayAllLayers = {
    "eyebrows" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,    },                                      
    "scars" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,       },                                      
    "eyeliners" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,   },                                      
    "lipsticks" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,   },                                      
    "acne" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,        },                                      
    "shadows" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,     },                                      
    "beardstabble" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,},                                      
    "paintedmasks" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,},                                      
    "ageing" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,      },                                      
    "blush" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,       },                                      
    "complex" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,     },                                      
    "disc" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,        },                                      
    "foundation" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,  },                                      
    "freckles" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,    },                                      
    "grime" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,       },                                      
    "hairov" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,        },                                      
    "moles" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,       },                                      
    "spots" : {visibility:0,tx_id:1,tx_normal:0,tx_material:0,tx_color_type:0,tx_opacity:1.0,tx_unk:0,palette:0,palette_color_primary:0,palette_color_secondary:0,palette_color_tertiary:0,var:0,opacity:1.0,       },                                      
}

function toggleOverlayChange(name, visibility, tx_id, tx_normal, tx_material, tx_color_type, tx_opacity, tx_unk, palette_id, palette_color_primary,palette_color_secondary,palette_color_tertiary, vari, opacity) {
    for (const [k,v] of Object.entries(overlayAllLayers)) {
        if (k == name) 
        {
            v.visibility = visibility;

            if (visibility != 0) 
            {                
                v.tx_normal = tx_normal;
                v.tx_material = tx_material;
                v.tx_color_type = tx_color_type;
                v.tx_opacity =  tx_opacity;
                v.tx_unk =  tx_unk;

                if (tx_color_type == 0)
                {
                    v.palette = colorPalettes[palette_id-1].hash;
                    v.palette_color_primary = palette_color_primary;
                    v.palette_color_secondary = palette_color_secondary;
                    v.palette_color_tertiary = palette_color_tertiary;                
                }

                if (name == "shadows" || name == "eyeliners" || name == "lipsticks") 
                {
                    v.var = vari;                    
                    v.tx_id = overlaysInfo[name][0].id;
                }
                else 
                {
                    v.var = 0                
                    v.tx_id = overlaysInfo[name][tx_id-1].id;                    
                }
                v.opacity = opacity;
            }
        }
    }
    is_overlay_change_active = true;
}

var wait = (ms) => new Promise(res => setTimeout(res, ms));

setTick(async () => 
    {    
        if (is_overlay_change_active) {      

        	let arrayNull = new DataView(new ArrayBuffer(256));
    		let componentHash  = Citizen.invokeNative("0x77BA37622E22023B", ped, 4, 0, arrayNull, arrayNull);// GetPedComponentAtIndex(ped, )

            if (IsPedMale(ped)) {
                currentTextureSettings = textureTypes.male;
            }
            else {
                currentTextureSettings = textureTypes.female;
            }     
            if (textureId != -1) {
                Citizen.invokeNative("0xB63B9178D0F58D82",textureId)  // ResetPedTexture_2 -- reset texture  
                Citizen.invokeNative("0x6BEFAA907B076859",textureId)  // ReleaseTexture  -- remove texture
            }
            textureId = Citizen.invokeNative("0xC5E7204F322E49EB",currentTextureSettings.albedo, currentTextureSettings.normal, currentTextureSettings.material);  // RequestTexture -- create texture
            for (const [k,v] of Object.entries(overlayAllLayers)){    
                if (v.visibility != 0) {
                    let overlay_id = Citizen.invokeNative("0x86BB5FF45F193A02",textureId, v.tx_id , v.tx_normal, v.tx_material, v.tx_color_type, v.tx_opacity+0.001,v.tx_unk); // AddTextureLayer -- create overlay
                    if (v.tx_color_type == 0) {                          
                        Citizen.invokeNative("0x1ED8588524AC9BE1",textureId,overlay_id,v.palette);    // SetTextureLayerPallete -- apply palette
                        Citizen.invokeNative("0x2DF59FFE6FFD6044",textureId,overlay_id,v.palette_color_primary,v.palette_color_secondary,v.palette_color_tertiary) // SetTextureLayerTint -- apply palette colours

                    }
                    Citizen.invokeNative("0x3329AAE2882FC8E4",textureId,overlay_id, v.var);  // SetTextureLayerSheetGridIndex -- apply overlay variant
                    Citizen.invokeNative("0x6C76BC24F8BB709A",textureId,overlay_id, v.opacity+0.001); // SetTextureLayerAlpha -- apply overlay opacity
                }
            }

            while (!Citizen.invokeNative("0x31DC8D3F216D8509", textureId)) {
                await wait(0)
            }

            Citizen.invokeNative("0x0B46E25761519058", ped, GetHashKey('heads') ,textureId)  // apply texture to current component in category "heads"
            Citizen.invokeNative("0x92DAABA2C1C10B0E", textureId)      // update texture
            Citizen.invokeNative("0xD3A7B003ED343FD9", ped, componentHash, true,true, true);
            Citizen.invokeNative("0xCC8CA3E88256E58F", ped, 0, 1, 1, 1, false);  // refresh ped components

            is_overlay_change_active = false;
        }
    }
);


function setOverlayData(pedHandle, data)   { 
    ped = pedHandle;

    if (data.skinTone){

        skinTone = data.skinTone;

        let pedIsMale = IsPedMale(ped);

        if (pedIsMale) {
            currentTextureSettings = textureTypes.male;
        }
        else {
            currentTextureSettings = textureTypes.female;
        }

        switch(skinTone){
            case 1:
                if(pedIsMale){
                    currentTextureSettings.albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab");
                } else {
                    currentTextureSettings.albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab");
                }
                break;
            case 2:
                if(pedIsMale){
					currentTextureSettings.albedo = GetHashKey("MP_head_mr1_sc01_c0_000_ab");
                } else {
                    currentTextureSettings.albedo = GetHashKey("MP_head_fr1_sc01_c0_000_ab");
                }
                break;
            case 3:
                if(pedIsMale){
					currentTextureSettings.albedo = GetHashKey("head_mr1_sc02_rough_c0_002_ab");
                } else {
                    currentTextureSettings.albedo = GetHashKey("MP_head_fr1_sc03_c0_000_ab");
                }               
                break;
            case 4:
                if(pedIsMale){
					
                    currentTextureSettings.albedo = GetHashKey("MP_head_mr1_sc03_c0_000_ab");
                } else {
                    currentTextureSettings.albedo = GetHashKey("MP_head_fr1_sc03_c0_000_ab");
                }
                break;
            case 5:               
                if(pedIsMale){
					currentTextureSettings.albedo = GetHashKey("head_mr1_sc04_rough_c0_002_ab");
                } else {
                    currentTextureSettings.albedo = GetHashKey("head_fr1_sc04_rough_c0_002_ab");
                }
                break;

            case 6:               
                if(pedIsMale){
                    currentTextureSettings.albedo = GetHashKey("MP_head_mr1_sc05_c0_000_ab");
                } else {
                    currentTextureSettings.albedo = GetHashKey("MP_head_fr1_sc05_c0_000_ab");
                }
                break;        
        }
    }    
    setOverlaySelected(data);
}

function setOverlaySelected(data) {     

    const overlayNameType = data.compType;
    const offset = data.offsetModel;
    const offsetVariation = data.offsetVariation;
    const overlayOpacity = data.opacity;

    console.log(overlayNameType, offset, offsetVariation, overlayOpacity);
	
    let visibility = 0;
    let tx_id = 1;

    let vari = 0;
    let tx_color_type = 0;

    let opacity = 1.0;
    let palette_id = 1;
    let palette_color_primary = 0;
    let palette_color_secondary = 0;
    let palette_color_tertiary = 0;

    if (offset >= 1) {
        visibility = 1;
        tx_id = offset;
    }

    if (offsetVariation >= 1){
        palette_id = offsetVariation;
    }

    if (overlayOpacity >= 0.0) {
        opacity = overlayOpacity;
    }

    switch(overlayNameType)
    {
        case 'scars':
            tx_color_type = 1;
            break;
        case 'spots':
            tx_color_type = 1;
            break;
        case 'disc':
            tx_color_type = 1;
            break;
        case 'complex':
            tx_color_type = 1;
            break;
        case 'acne':
            tx_color_type = 1;
            break;
        case 'ageing':
            tx_color_type = 1;
            break;
        case 'moles':
            tx_color_type = 1;
            break;
        case 'freckles':
            tx_color_type = 1;
            break;
    } 

    // overlayData[overlayNameType].push(
    //     [
    //         visibility,
    //         tx_id,
    //         0,0,
    //         tx_color_type,
    //         1.0,0,
    //         palette_id,
    //         palette_color_primary,
    //         palette_color_secondary,
    //         palette_color_tertiary,
    //         vari,
    //         opacity
    //     ]
    // )

    toggleOverlayChange(overlayNameType,visibility,tx_id,0,0,tx_color_type,1.0,0,palette_id,palette_color_primary,palette_color_secondary,palette_color_tertiary,vari,opacity);
}