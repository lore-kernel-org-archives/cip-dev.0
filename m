Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF72C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 13:06:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.14917.1740747967475206616
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 05:06:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51SD65162736845; Fri, 28 Feb 2025 22:06:05 +0900
X-Iguazu-Qid: 2yAbuzQy1FTPce4d05
X-Iguazu-QSIG: v=2; s=0; t=1740747964; q=2yAbuzQy1FTPce4d05; m=CR+tv5xhRNQDIHvDI+MASdGV+CRLxIxdfMtd1XcZxf0=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 51SD63iD543730
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 22:06:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbjPyg9SEBS41kVykLJlQFLgh3vjqX69rZNnB3uhwdRE03syZfwCwZ0f9IegdMwZ74gjKuxc86J9oPaZsR6YffuAgmsPnlMUtYCzJYcpmTm2kQd3I5cjJ2W1VU8AV2YSCEqR9rmRWsA/ok6MJYJILRkshnVv5Ia3oYou3Op6v92LzbF6s1Oas2ScpNPRu1K9RzwRxEDEcgwIl2AdRuU/FY0z60SWdj+33MJ6yvzdvaqkZ0NF1c3d+lbdfwK7MOWmMpiaCXNIRlobjx8Wg4e7JHt4+CGo1If5DgnSv3h2C/VxYmfwvE0Z8tDK6i5AUOHe1LuA/WM2GMtzLUYvSgIk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxtBLNagovyVKVRS6A4tyuyh4Q8xG/d8AMsNFG28XUQ=;
 b=iRUfvyy8jvFVryYpVxsjpHqukhZ+iMqQka1gO1fGcqJUcFrKtpm20T8wLhwyJxEitQ5MfsOcpP0p+74p30Cf48El/C/w21ckhFcmspjL1INkIx3kzmrhAnewpQO7f0Yn/XzjoJ961waF0xklImSaxLP9Pcr/sRi/b1vWZrzrbaIPRGxiJcTTqN3mxU7fnxCjeCnl2JbV7MYYs9AU7zSx6zNoEJh/2+d6WuN2bPrZ2JpeQT5+EX3So59rGwHP3DvZdt+D/ep+4N9ttc68x28/i9kgkHV32kP5wOT44INy9NDJ/fVATzMTw61PuD8xoWkSFrVZfB3pt1SwCO5vdgz5Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: Re: [cip-dev] Updating root file system used for kernel testing
Thread-Topic: [cip-dev] Updating root file system used for kernel testing
Thread-Index: AQHbiAY0k37sypfPYkK+BZ6qIlAP7bNcrpRwgAACZGI=
Date: Fri, 28 Feb 2025 13:06:01 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
References: 
 <OSCPR01MB1483816E3365201CB54911E2FC2C22@OSCPR01MB14838.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818C4E6A1A2A38D174182D892CC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB14818C4E6A1A2A38D174182D892CC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|TY4PR01MB14298:EE_
x-ms-office365-filtering-correlation-id: 794acb08-10ae-445d-0e48-08dd57f8a693
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007|13003099007|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SnNxMGpYVzZjK0pTbFFFM0JQdFRrOTNvMER6QXRYWFFTVkRIRnZFamox?=
 =?iso-2022-jp?B?M0I4Zmp3VXhORHI5NTNlandUUk1TL3VUWWpTdkVKMXFDK2FVa1cydkVw?=
 =?iso-2022-jp?B?cHRzSGU4cFVmQ0NrRXZtZUF5YURRTW1qanVGL1pVVmFjUlYyT1NyV3FH?=
 =?iso-2022-jp?B?T1gxTktXT2hBQXkxeitIV1BGcVB5aVM2c3FPVEF2cCtRNzZhMU11M2Fj?=
 =?iso-2022-jp?B?L0tDdzZWcTlGNGdOQUFUek5MbUEyTnJreURUQmVOVzl5VlBmZmo4Mlc4?=
 =?iso-2022-jp?B?dUFtTXo4YWxGTzBObU5VYU5SeHdsWEh5enJlOHpmVDlIVVN4YUlGTytr?=
 =?iso-2022-jp?B?WVhKaGF0QW9BL01XaXJtaUpVR0ZhdUZjSDl1Z3ZXOFB6am43MXVDaXB1?=
 =?iso-2022-jp?B?TThVcFkrUFExaTZjUHlsbW80RVJVZjAvMVRWS2RVZit6QnN1QXVZay9P?=
 =?iso-2022-jp?B?QUJIc1BjQThkTWloLzJkcnpaTEFhaElUVkd6SEFJYUdqVDZyTE12bTFD?=
 =?iso-2022-jp?B?YU5rTDh2ZWRkenNBdS9uR3J4bEcvaSt1UzRPMDYvUUdMbEoybWc4YVdi?=
 =?iso-2022-jp?B?Z3E3Vm5iM3h3Mm1LL092Z1h6azNPMktSSm5GdTNpU2tzbys5c1hwRUhi?=
 =?iso-2022-jp?B?OWFjMi9kYjR3OWhyMThwS2JqbUYwWXhQNDI5aUpTWVRZeTBaSFpZV2wy?=
 =?iso-2022-jp?B?ckU5Q25MOGl6UmJPb3lXN045dXBuZmJEVFVKRXd0aFoxOVRIMktWaENm?=
 =?iso-2022-jp?B?Y1pBN1NhVHVzWDY0NkNtOWMwb1Jhd0ROMDNlVmZYRGpYL2pvWjJjdXVE?=
 =?iso-2022-jp?B?V3hKL0NJZlpRaXA1RVRYdmZtN28wN1NLVWhBTHdvaVdpRi9ObWRLR0hZ?=
 =?iso-2022-jp?B?U1dXd2pMYmVPaDVVNkpic0psdUg5b1BNMmZKanp1c0MycmJjUDZGUXp4?=
 =?iso-2022-jp?B?OVhwMThwbTRIeEFzUnpNUHZDUjl0NmtxVUdER2l4MXl2anRWbHJrMllS?=
 =?iso-2022-jp?B?QjJUbjZTUkJBT2lMT1FwQjYwZzQzN1BTYlk0WDFNSm9rUGN2NGJrUUdE?=
 =?iso-2022-jp?B?dmp4VDhvVmlma2VEaHFqaHhLNWhpYStwdjlyUkV1MGVLSUg5RlhRNmc2?=
 =?iso-2022-jp?B?S3dBZ3ZxSndrYXZ2Qzl3Rlc5L1NidjBxU3ZUTVN5V1U5aEJiUVhoakMv?=
 =?iso-2022-jp?B?N1dMM2tSTEJOcVJZQmlJS1NhMjlVb3F5cUdnTDNEbXNjZ2JqSFl5bnZO?=
 =?iso-2022-jp?B?SHRhT3dkRE1wYWZ1Q1lHbFBDOFIyVTBkbjRVTHNGcXhXcHZCa2xaSXlv?=
 =?iso-2022-jp?B?bXl0bit0eC9Fd3cyRHF4UHByUDBuMVpwTCtlcEFWZWtFRFhKQ0RyTmxa?=
 =?iso-2022-jp?B?ZVhOelBkcy9uRzZYbXp0KzlabmVSTWdXVGppZVk3U0NNV291Y2lhU01q?=
 =?iso-2022-jp?B?b2NrOTN3anJTeXJ0NENib2lEeHB0dm1vYTl1aDFQWWNIa1FxRXordXBO?=
 =?iso-2022-jp?B?ZVc5NHlwdVBiTTVPcHFVQ0pQclovbU92MzJYblhacEVTWUJYVVVSbWRz?=
 =?iso-2022-jp?B?akxibkFNdGFrUXgzVFdNMkJQbWtKZnl0N0VjOGNtcmY5ZDdmeXRQSDRU?=
 =?iso-2022-jp?B?djFPcUEvT0xOY2Y5b2svaFRpdWRwdm52ampKTTFmdlpoakpma1Q0MnJW?=
 =?iso-2022-jp?B?dXUraCtkWUtmSUM2c2JsL1BRMUg0MzRoaXBGUllqUHB3Q0lpUVlGWlVt?=
 =?iso-2022-jp?B?UE13UWxaVmdZVmtGcU55TS9KZ3duUGFNN25Ybkc5WnlUR01PWGRBM3lF?=
 =?iso-2022-jp?B?QWNnT2xIR2xIQzJnejRVSkc0U1ZMdXVsUE14OVRYd21xcU4rSmQ5TnFi?=
 =?iso-2022-jp?B?NEFWWFlUZ2RKc3lwMlVobUxCeURacEtIMm5tWnN3a0lSTk52aStTQmM4?=
 =?iso-2022-jp?B?TW5SZGVzeVQrSHZaSVA5cFR1UFQwVW0yMHV4aXcyRU5OTGlNclRRT0ls?=
 =?iso-2022-jp?B?RHFpMlZhc2oyMm5DWVQwWWkwdjRLODl0UnlLV2MzQnFyYnZEbTAxVDBS?=
 =?iso-2022-jp?B?QlE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(13003099007)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UWp5MTNEK2FwZ1FRVEMxeitKbTdkZlpidmdBWGplaFlHRVlEQUtCSGVu?=
 =?iso-2022-jp?B?eVU1Z1QxVmZ3aldrd0lWc1RET1pidUVoL0g5N29RMDNXVlpjMWhyMTdH?=
 =?iso-2022-jp?B?V25xcGRHaTJSaWdFM3dIVEphZVdwd3hxMVZnOWV4QVI0NlYxb3E4U0Vi?=
 =?iso-2022-jp?B?cXVia2JOaFZQNk13eEZ6SGFJUk1jeC8rdm9PZ3hseC9vTDJSdndjbTFy?=
 =?iso-2022-jp?B?MWVIZlRLeTJHaC85aDY3VndHV3pwbnY3cGpqSGNrTlNzTDU4VmwySXRr?=
 =?iso-2022-jp?B?UStKYytmMnZ3emFVQ05HMnpsV0czTlpsZGp4NTRidGdkaXZnWEN4Yk1t?=
 =?iso-2022-jp?B?VlpTTGYzZlFhYWRPQXVIVkx2N1ZSMndnWWh0WTR4N0JlN3NKWFNVQWtU?=
 =?iso-2022-jp?B?UG5pVVJqSFoyaWpyR0RseXBGSGwwTUd0OWVnZlkxcmlQMmlyOXFVYS9s?=
 =?iso-2022-jp?B?V3l2VXJXa3JPQWViRkV1U3dNblZvYkhYTG5WNlVOczJiVktUYUxBUEZL?=
 =?iso-2022-jp?B?OURHYWdNb3o2ZmxwV1MwZ0p5ZGpmRFFxZGovaVF2c1I5VE5ia1g4R1Y0?=
 =?iso-2022-jp?B?cWV1OUhpRTdlTjBLdEYzMU9FV1l3RVRYZlluTkRocldzcXRMbWROY3Fa?=
 =?iso-2022-jp?B?bUhDTzF1aGlkT1plSyswQ2F0ejcrOFB0YVQvcUl5clI4RVcvVmgwck5R?=
 =?iso-2022-jp?B?bi9PTmlQYTVCMXNrK21zRXRPVGJrWlIxUlc0UVVPN1FUalM1NGxjald1?=
 =?iso-2022-jp?B?WWJFbFduWUdNZ3I0dTlYQTdxNnRZQzNCczluY1d2b0Zqand3elU1Y3FF?=
 =?iso-2022-jp?B?Z0ZXSjFlSEs2Smk4cVdGSVM0L1lXZFEvMFJBbUZVdldMckk0NTJTQ0tn?=
 =?iso-2022-jp?B?ZzdRRVRGSWYzamI4N2hTcFBCVW9WY0lDZHU5a0JXVHVlQzhVNlFPQWE0?=
 =?iso-2022-jp?B?VG4wOXFNZXl1Skd3UGgxUXpLVmptZjVrZ04rMXdndkd2UFMrVUNRcmJH?=
 =?iso-2022-jp?B?Z01zNW04bXAxMHh0WjF1VTJVeW51VWc4cU16MlRhT0xBNVJyZkErRXkx?=
 =?iso-2022-jp?B?SjRDb2VQWmxsVFJlN3B6cW5CY1Q4RURTeUFqdkJ5VWg5ZnBRSzRrWENE?=
 =?iso-2022-jp?B?ZGxoNnhmcmZKOUpGOEFIN3ZoVlR3eEtGdnR4SEc0ellacHo4eUFyaDM5?=
 =?iso-2022-jp?B?aFpBSGZTcDExSStGRjlDMWlIem5NMkQrVk8yNzBvR1FDZmZUWnorQWVQ?=
 =?iso-2022-jp?B?ci9LVG9Ydm91cVFZK0dYM2xpbkdHSXJ4VU5ONnhoVjVTRG9wWDF5dHc3?=
 =?iso-2022-jp?B?UGxGVmJ5VDNTd1UvSWY5a3dwTXFHQnduMVM4SW9oQTBtdTdKVndRempX?=
 =?iso-2022-jp?B?b0xscjUwOFZ5aUorWFM4MjBxSnF4NE1GN1pJN2hFdklmQW45bVZWVWcv?=
 =?iso-2022-jp?B?VGVSdEkvWld3NU9zYlRNc0NvdTArdzQ4bkZwb1JWenlnVzlWUFBwMk5N?=
 =?iso-2022-jp?B?NGN5ejNOV2Vhd2drREVGUVVvbEI1Y1hZblkybDg4SldENkpsSkxET0p3?=
 =?iso-2022-jp?B?cXhjRXQ0bEFQaGZQeUJVcDRYNjRLd0JoN3NKUG5yNVByNTd3ZW0rdjFE?=
 =?iso-2022-jp?B?K25HajZwWnRiZWV0WE9NQnVMRFJSSDJ1L1FOcWg1MHhhaVNPdS9ZOVRj?=
 =?iso-2022-jp?B?Rnh3ZnVXV0I5VEVHZGh3NjFlMHYrMWViWG9wS0IwcTlyNlMvcjhRU2sx?=
 =?iso-2022-jp?B?bE9wYVFrZWJHbWVOMVBxK3pPTjZaL0NMRkZDbTJyUEkyUGxhVmJad2Ur?=
 =?iso-2022-jp?B?d2cxNVdFdFI1R2U3eTBrUnhPRmFlSlZUSXRVUkhRbHlyYUpLdnl5ajc4?=
 =?iso-2022-jp?B?SVRGWlNna2FEd2RWWjRXSlZFcmpGZHBxNmJSOUU1TjhZNVJVTU9MdDla?=
 =?iso-2022-jp?B?V2NLYk52ckRYSjNIVk4rSUtRdnVpcTBuelgySHRLZlpndEZBV2hULy9Y?=
 =?iso-2022-jp?B?R3VwekpSNFZtSTFCWUt2czI0VGgwY2VCUG9SVEczQlFrbzVDTitzcFNW?=
 =?iso-2022-jp?B?UnFQTFl6UjBrWkRhOHQwOU9CY0pVUHhNa0ZGUWRvemp5ZmI4RTY4MkV6?=
 =?iso-2022-jp?B?ZXkzNnJpQTZNUmhUSnJVT2FLUnRDL2E3K0VRb25BbmoyUEdnd1NLZjMx?=
 =?iso-2022-jp?B?enMwZG1mbE1hdWpHMTRoR09WMnBYaUNaL0RTbG9nclJrRmtTd2VtcWt6?=
 =?iso-2022-jp?B?K1ROMDhCdUhVYUpMUm5iRGJxYlE0ems4UGtrOGVxS1Q2cXJEUlNHcmJw?=
 =?iso-2022-jp?B?ZFJ5VFViejF1NEdwaTJHeFhuVnBkTXg1Ymc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794acb08-10ae-445d-0e48-08dd57f8a693
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 13:06:01.4554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +YwBx7ZqT9QF/UgC9m/PdFBeh4GeemMZRKLjhSUFn4eiupz5Rr89omG34rS/ZiMPiZU9ZAJMYUrX7o1Ozd+ZrFrzT92AhWPUkd0YXnQpB+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14298
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 13:06:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17987

--_000_OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Iwamatsu-san,

Thank you so much for your response.

I just wanted to mention that we tried some things in the past few days. Ta=
rgets like [1] if deployed shall push the rootfs (ltp installed) images to =
s3. I have modified the following job LAVA | Scheduler | Jobs | 1250098<htt=
ps://lava.ciplatform.org/scheduler/job/1250098> to use the rootfs image fro=
m cip-core instead of legacy ones and the LTP tests are running fine of ref=
erence hardware.

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gi=
tlab-ci.yml?ref_type=3Dheads#L203

Thanks and regards,
Sai Ashrith

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Nobuhiro Iwamatsu via lists.cip-project.org <nobuhiro1.iwamatsu=3Dtos=
hiba.co.jp@lists.cip-project.org>
Sent: Friday, February 28, 2025 6:26 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; Chris.Pa=
terson2@renesas.com <Chris.Paterson2@renesas.com>
Cc: jan.kiszka@siemens.com <jan.kiszka@siemens.com>; hayashi kazuhiro(=1B$B=
NS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B)=
 <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DI=
T-OST) <dinesh.kumar@toshiba-tsip.com>
Subject: Re: [cip-dev] Updating root file system used for kernel testing

Hi Sai,

> Do you have any plan to keep these rootfs tarballs updated with the lates=
t
> version of LTP through CI ? If not immediately then we want to make chang=
es
> so TWG always uses latest rootfs tarballs for kernel testing.

We had talk about this at the kernel team meeting. I'll take care of it.
As Kaz wrote in another email, I am looking into how to make the cip-core i=
mage available
for kernel testing. I am also working on doing this.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of sai.sathujoda@toshiba-tsip.com
> Sent: Wednesday, February 26, 2025 1:28 PM
> To: Chris.Paterson2@renesas.com
> Cc: jan.kiszka@siemens.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =
=1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M=1B(B
> =1B$B#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B
> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>;
> cip-dev@lists.cip-project.org
> Subject: [cip-dev] Updating root file system used for kernel testing
>
> Hi Chris,
>
> Hope you are doing good.
>
> We noticed that the LTP version being used in the following rootfs tarbal=
ls used
> for kernel testing are not recent ones.
>
>
> 1.
>        https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qemu-
> arm64.ext4.xz
> 2.
>        https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qemu-
> arm.ext4.xz
> 3.
>        https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64.ext4.xz
>
>
> Do you have any plan to keep these rootfs tarballs updated with the lates=
t
> version of LTP through CI ? If not immediately then we want to make chang=
es
> so TWG always uses latest rootfs tarballs for kernel testing.
>
> Thanks and regards,
> Sai Ashrith



--_000_OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2OSCPR01MB14838jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Iwamatsu-san,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you so much for your response.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I just wanted to mention that we tried some things in the past few days. Ta=
rgets like [1] if deployed shall push the rootfs (ltp installed) images to =
s3. I have modified the following job
<a href=3D"https://lava.ciplatform.org/scheduler/job/1250098" id=3D"LPlnkOW=
A1d7107a3-60cf-3afd-0a0b-b9e3fee5a302" class=3D"OWAAutoLink elementToProof"=
>
LAVA | Scheduler | Jobs | 1250098</a>&nbsp;to use the rootfs image from cip=
-core instead of legacy ones and the LTP tests are running fine of referenc=
e hardware.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
[1] <a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob=
/master/.gitlab-ci.yml?ref_type=3Dheads#L203" id=3D"LPlnk">
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/.gitlab=
-ci.yml?ref_type=3Dheads#L203</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Nobuhiro Iwamat=
su via lists.cip-project.org &lt;nobuhiro1.iwamatsu=3Dtoshiba.co.jp@lists.c=
ip-project.org&gt;<br>
<b>Sent:</b> Friday, February 28, 2025 6:26 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> jan.kiszka@siemens.com &lt;jan.kiszka@siemens.com&gt;; hayashi k=
azuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!=
{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh kumar(=1B$B#T=
#S#I#P=1B(B DITC_DIT-OST) &lt;dinesh.kumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b> Re: [cip-dev] Updating root file system used for kernel tes=
ting</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hi Sai,<br>
<br>
&gt; Do you have any plan to keep these rootfs tarballs updated with the la=
test<br>
&gt; version of LTP through CI ? If not immediately then we want to make ch=
anges<br>
&gt; so TWG always uses latest rootfs tarballs for kernel testing.<br>
<br>
We had talk about this at the kernel team meeting. I'll take care of it.<br=
>
As Kaz wrote in another email, I am looking into how to make the cip-core i=
mage available<br>
for kernel testing. I am also working on doing this.<br>
<br>
Best regards,<br>
&nbsp; Nobuhiro<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt; On<br>
&gt; Behalf Of sai.sathujoda@toshiba-tsip.com<br>
&gt; Sent: Wednesday, February 26, 2025 1:28 PM<br>
&gt; To: Chris.Paterson2@renesas.com<br>
&gt; Cc: jan.kiszka@siemens.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B=
(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M=1B(B<br>
&gt; =1B$B#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dines=
h kumar(=1B$B#T#S#I#P=1B(B<br>
&gt; DITC_DIT-OST) &lt;dinesh.kumar@toshiba-tsip.com&gt;;<br>
&gt; cip-dev@lists.cip-project.org<br>
&gt; Subject: [cip-dev] Updating root file system used for kernel testing<b=
r>
&gt; <br>
&gt; Hi Chris,<br>
&gt; <br>
&gt; Hope you are doing good.<br>
&gt; <br>
&gt; We noticed that the LTP version being used in the following rootfs tar=
balls used<br>
&gt; for kernel testing are not recent ones.<br>
&gt; <br>
&gt; <br>
&gt; 1.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://s3-eu-cen=
tral-1.amazonaws.com/download2.cip-project.org/" data-auth=3D"NotApplicable=
">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/</a><br>
&gt; cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qem=
u-<br>
&gt; arm64.ext4.xz<br>
&gt; 2.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://s3-eu-cen=
tral-1.amazonaws.com/download2.cip-project.org/" data-auth=3D"NotApplicable=
">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/</a><br>
&gt; cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qem=
u-<br>
&gt; arm.ext4.xz<br>
&gt; 3.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://s3-eu-cen=
tral-1.amazonaws.com/download2.cip-project.org/" data-auth=3D"NotApplicable=
">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/</a><br>
&gt; cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64.ext4.x=
z<br>
&gt; <br>
&gt; <br>
&gt; Do you have any plan to keep these rootfs tarballs updated with the la=
test<br>
&gt; version of LTP through CI ? If not immediately then we want to make ch=
anges<br>
&gt; so TWG always uses latest rootfs tarballs for kernel testing.<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_OSCPR01MB1483865B76B07B5A0450B0CC9C2CC2OSCPR01MB14838jp_--


