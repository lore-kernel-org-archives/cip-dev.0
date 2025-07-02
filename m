Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D89C83013
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 06:57:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.17688.1751439464260007097
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Jul 2025 23:57:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5626vfMc931458; Wed, 2 Jul 2025 15:57:42 +0900
X-Iguazu-Qid: 2rWhBFYKMY3LjCWIeq
X-Iguazu-QSIG: v=2; s=0; t=1751439461; q=2rWhBFYKMY3LjCWIeq; m=zHTPcRDwrwklGnAi1gdzQtEmezMZWwVyGbCiXdyPhsQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 5626vep83480666
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 2 Jul 2025 15:57:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V2YQXmzWBH+sL7Rj06Cd99G7PKN1E9x4GHQIsTqBs+8n4sLkCdIqosY42sduS53lmreXuk6X71c8PfgYGfWjt/9Y2jCzW1YFY63IVBb0rDJoKQDfM0MJqUWi/C/GVY/Vea+89GeuTv0pDXuim27HRik9vTJvt2iwnMFmFhRsLUiUOycKW2XQTTyJFrqKI7DrSrxs9fw/BXHL2hbm8i0jEtrhj9oKxckaFF7BmFfc4p3Zt/1cGXl9IC4XMEr76nvmYHGN32/wwluMbepzAKP3bu7fBq5HvdspyJfm+hjgBnaSdQAD/HgpS9/W6pJjc7IH2Yt5M8N8JK1ZsRiJaix95A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3381alN77l7EtKZH3C/slIxPl2r/qiELSyeLPyq6eZk=;
 b=IcTsQtM/rVknhNNRzI3meDrLrqhYY2eC3Lat6/6YFoKY0F5cOB+i54KfvYJbwax03c+izXoWOinOndeF+S32fVPiGefijHY4pNEB7OQUCFjmbQy5UG+b1pHrG7Y/ohPRdruBi08I+wdrds9ak3RNe5iYFeGl2k3qMlTxo0A+WqPzoIz5jVZbvCA/mImVJyw+VsSQY4tkZqj0J9C+xeQb3LdfGA/CS9fzEObjiLFaXOrgS0s2W1KsIFneaOQxczjzijpuwMwudmqQnyfcq14QwyZU5lxR+zD5bIUuZ5Fyu6yVPfbl422bIQY2lFrkbPvoxoMpbXeLlAWqqOHHez9wwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: LAVA: Support ROOTFS dm-verity corruption detection case.
Thread-Topic: LAVA: Support ROOTFS dm-verity corruption detection case.
Thread-Index: AdvrHhlzn/A/DOQaQCWzDQhadgxFug==
Date: Wed, 2 Jul 2025 06:57:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB1107541F904CDED694538F4F2C740A@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TY4PR01MB15195:EE_
x-ms-office365-filtering-correlation-id: 5979fa71-3e2d-495d-fe8c-08ddb935bada
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|8096899003|13003099007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZGlUQlZLdWJXS0pyamhRMW9UMkVqVVhPQWYraTEyNGdGRWVIMGx3SWNS?=
 =?iso-2022-jp?B?Ui9CWG54QUJkU1pQdm5HWC9OcmR5OWMzUDdzTHpzL1ZqWFhKS0t6NFF5?=
 =?iso-2022-jp?B?QW9iclJGODl3MFhzVkxGYmJqUGE0ZjNXNnRvRndueHhVNXkzcEFSUGdG?=
 =?iso-2022-jp?B?S05ERSsvY1I4cDlYM0xQamdNQ3FZTEJxUlB2RERSY3MxK1E0V3lvRXNL?=
 =?iso-2022-jp?B?aWhraGtqckdOT3JPeTB2eEpvWjcxNzBoSmZMQ0FYWFU1eko1Z1ZoOTly?=
 =?iso-2022-jp?B?TWtIcFcwbW9ydnFlRm5lblBqUjVGeDBjMXJQd052UWRaV2lZczg0N1M4?=
 =?iso-2022-jp?B?ODh1NkxRdEJoZDczNmJqOTQvcUkxdnZjQWVqZThBK09OeTVrU2Y0dHZw?=
 =?iso-2022-jp?B?aVUzM2R5SXVMenhza3d0cGkxZXZacm9IUDlsUkx4cGtYRkRNYlVjaHRN?=
 =?iso-2022-jp?B?UDRXdko4Umpyck5WR0xPNHRqU0EwUG1lWHJhYyswOHRoamEwUnhGdWFB?=
 =?iso-2022-jp?B?L0VtQ3NtamNKSnBjZzhnY3Zva254NmE2WWd1YjNPaHlRZVZBWjl0UlJw?=
 =?iso-2022-jp?B?L094SFdsMGtDbFgxRmpCZjhRYUI1QWF0NWhNMUxVazlPMXNzcEd4T0ta?=
 =?iso-2022-jp?B?QkN0d0lXTFBGdkxzVWZKVkhIUDNhc0YrbWNObFNNRmpOLzJMciswaHhT?=
 =?iso-2022-jp?B?Y3RVazlocDRwdzRKSU4xSDRPaUVaK3NXbUhMRXZJSERxaDIzSzhSRkd2?=
 =?iso-2022-jp?B?NXB6MzRMUTI3NlZTbDlHQzVGYkd4TjBVbU5ySVlNZTVvcmFEQmR5d3FO?=
 =?iso-2022-jp?B?N1NxajI2ay9VUjB2Z0ZyMVExNnk1cUhWK0R2TXFaN2Q3c0tCMGZGcUNp?=
 =?iso-2022-jp?B?U2RxaGhHTUUyd2Uva0dZb1AyM1MzcFJNY2I2emhqS0xianpuUzd0MDBL?=
 =?iso-2022-jp?B?N21LNmZFQnkwWjNnUmI5ZmJBUHVSa05SNDB2YnhrcXRCWDhMRDhteG9P?=
 =?iso-2022-jp?B?UzhZcmx6K05SSVZ6c1M1U1VGbDFDTDNZTUd6cHAzbFVWTHF3SWRsYmsy?=
 =?iso-2022-jp?B?Skx5bks0eHFZLzRJM3IwM09ReDZpb2VJdlpTLy9PUStRQ2s2NnRYdWhR?=
 =?iso-2022-jp?B?Q3E5WEw5ZHRQUTM4d0x4dGwyZm54elJ4RUE2RG1taDFzRTNtWEdqVGZh?=
 =?iso-2022-jp?B?WCtXMGs1amw4SlhuemxpSCtTek9QTEdHRU5WN042cUZxeWVtY2lNMlYy?=
 =?iso-2022-jp?B?cmVad09nbjNuNGl1S2MrM3ViUGRoOGxybExXdTc0Ry9VUHBPb29BU1Yv?=
 =?iso-2022-jp?B?VVd0cGsyOEx4Uld5SUhhWnkydUdJUHA5akZwRWgycDl6WjJjY1BlMDAv?=
 =?iso-2022-jp?B?VmVhL2k2SVAveERGWlVDRnVZU21rUzlVM1BNRXB6cHZ5MDN4UzZXNWhF?=
 =?iso-2022-jp?B?clJUOHhTK0RIait5dFV2aHZXU3FyelZrVUhYMU1BNEpFdzhUT2pUSDkr?=
 =?iso-2022-jp?B?WXdQMHIrVWhINjdLN1VEV1o4U2pFTm9hUCt3TzhZV2hZNExaT01IYXZi?=
 =?iso-2022-jp?B?Yk5wZWtiMTVrQU5tTDB5Wkp3QzFzajB1NDB5anhSY2Rnajl0L0V1NXJu?=
 =?iso-2022-jp?B?ZmJDd0o5MHVBRGJXTGtJYlRTTHhwaE5SQnNtODhKTnN4bVlWbTg3MGp5?=
 =?iso-2022-jp?B?OFVGVnlkenlwU3BZaDBvSmdXRHUwMmQ0RE1OVGJuanNIYXcwVE1qRzUx?=
 =?iso-2022-jp?B?QVIza3VuZStWcURLdVJ6d0pZZTZodWd6T1JabnlhTnAvZnlNWkV5d2Zy?=
 =?iso-2022-jp?B?ZlRMN3BtQzNkQ09ROW1oYy9DYkRtYVorSHY3SlhGWHJxang5b2xaUUhT?=
 =?iso-2022-jp?B?bmFxQzJhc2lYSXJKWVZrN0pVRWV2UHJ3MmpDMjBRWnNtRzRhQmNaM0hI?=
 =?iso-2022-jp?B?Z3N2dW1Sd0F5L0p0Ry8yMEhJbmRtcm1uc1Y2Sk1KWG00dW44UjhmVk1a?=
 =?iso-2022-jp?B?Ym9HWURvdUg0UlgxLzRUYytHNG1vQ1hnUzk5K0wrbVE1ZEg3LzFvTjF6?=
 =?iso-2022-jp?B?RGtNNFI1MHUzUkNCK1RicnZnTEdUWDA9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(8096899003)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V3lKRGw1bi91dmltdzV2K2JDZzhwWDV1Q2xpU3UvODRNUmNFWVNYWlAw?=
 =?iso-2022-jp?B?K3gwM08wMHBWQW1rOFJ0RHdTRTY4YW9mRTgyRkt3Tll0RFM2WlBCZlVN?=
 =?iso-2022-jp?B?SnZzSzE4NWpVenFONkhTZ2NKRVBHTEIzL0R0NXFxOUxBci9hRzBCbkdD?=
 =?iso-2022-jp?B?YWV4MUl1eDUxZnBVRitvY3AxMXVmdytpdTkrRXFHc3Z1b3drMGhsOHU1?=
 =?iso-2022-jp?B?Nk9aT1dGUm9HWWNSNkdITXZDUkFwRkl5eFJpWHZMRUpmdEx2S3RpU0Qy?=
 =?iso-2022-jp?B?Q1czMFRYdzZadXRhMWRmTjNlUHFXMzFreVhlWTZCTFVLdkpaeDN1bmFP?=
 =?iso-2022-jp?B?L3hhV2RQaDFTak44K3lFWnpDUmUxRldVV0Y0bFlXMVYvWXIyT0tvZ0dZ?=
 =?iso-2022-jp?B?RitkN1FGQU1vNnYwUGpnRW10RXo1VEdXOVJUbVNqTm1mSlZJRjJZNExt?=
 =?iso-2022-jp?B?c0VJUlNZUWc3MXY2MVBiYUc0dTc4UHFaZ3JaeFlwem9wSUVZT1lPaDNw?=
 =?iso-2022-jp?B?cFJLTzAwWEhJeWVwSUEzcEljYVlEL2hHclBtY1VoV1JTemNsamdLanpK?=
 =?iso-2022-jp?B?TmFRc2JrdU1tV0RaazBEVG4zdmptbnhjRFo4bWRUNFpPdmJCM2tvZzF6?=
 =?iso-2022-jp?B?ZUVwUk9qZWhvNHJheGtlendrRkdaYzU0MlBZeGJHdFRyQXRJaFhYSHJJ?=
 =?iso-2022-jp?B?TkRxWXFMWWFud2lIOWNTS094dmN4UTNIdVM5TkRzRFlPVXVscC9UN3J1?=
 =?iso-2022-jp?B?ckVnNmI0TU5SRmpaN3N2ZEszeVhpNklROHMydWNQNjVJMlBlQjBiL3pK?=
 =?iso-2022-jp?B?aHgzRkpScXoxVFh1WnJjNXYzUGk0ZDNUZTNGSHg1U1BUZStyWGNDMnF2?=
 =?iso-2022-jp?B?N0IxSFlldmJGMklDTFo3RWRaK2M1TVE4dmNmeXdObWdiMmgrSVpzbW5P?=
 =?iso-2022-jp?B?VTRWYmZDbm5iVFExME82d1gzWHBVREgxaUtXWWQ0aFkyckNmNHpMMDJl?=
 =?iso-2022-jp?B?ZWZXWS9WNUNnTVAwK3kycFpkT2N0STdFbnZYd3kxWUJGN1FIM0htWDdw?=
 =?iso-2022-jp?B?ckQxYnJNbzNPalNBL3BSL2lCYXNKWjM1NkxMSE51Q3RFSk1mTWh5bmZF?=
 =?iso-2022-jp?B?NmNSUG93eGt3M3VLMDRlUTVaVVo2Y2tYVVdGSjZjODh2ODYxMlhQclNu?=
 =?iso-2022-jp?B?b2xpNUFFMnhEUTJ3TXhRdlBFczdtVkxaT1VicERxVitqbnFzZy9vdWZa?=
 =?iso-2022-jp?B?UXJObFVsS3hXeTJvNllNbmdzaUpGK1E1NWhMSC8yV2x5OElRSDY1WmZI?=
 =?iso-2022-jp?B?ZFFoMFFYYmwwc0JEMHBPa0FzNjRRSE9rQko3ODYxQWV4MU0yRVdUVWJx?=
 =?iso-2022-jp?B?ZzduTVczeHhieVJyNjJra3piRkl3Q1ptQzVFUENXZEc2UmJVL1RhSWRE?=
 =?iso-2022-jp?B?WnJVVXlUMmwzR29zbWx6c3F1dnFxV09HY1hydUovcDJZREpjWG9aUnM2?=
 =?iso-2022-jp?B?RnpwNm9ueEFrN2U1cSthQzdwb2htVzZpNzJWZjhwL3c4b0pIdGFHQ0RT?=
 =?iso-2022-jp?B?aEdBQmhCeXd1cjU2SXRmSUlobHA5UTF1Y1BwRS9melBYV2o2Y2luQzJR?=
 =?iso-2022-jp?B?SythVzRIdTJpUlBiczJab01FQlFMajJseEtOY3RKTHhWS1AwL0tyT0VF?=
 =?iso-2022-jp?B?WExiZ2xTZlVoeFlGSEM0TU9YUXE3V0s4UHUycmEzQmRRcVJrWWlCSlNG?=
 =?iso-2022-jp?B?NVNHR3h5N0IxYnFPYWZkckcvQ2xHTHdpSGUyN3lPcnExek1yOWNyMjNW?=
 =?iso-2022-jp?B?ditCbDM4SGJoaFpVcjcybUJZRXUwK3c5K3phcHRyalc5T1lFWTdPUG13?=
 =?iso-2022-jp?B?Z3hxTi9MNjZFcnJFZnN2THRadjRxTyt5NGJ4RkFLTDVOWFFBcFoybGFk?=
 =?iso-2022-jp?B?cCtDb1Z0OWVlL2k4bTVyVGdwd3BxVVdsSEVqWFVOaEo1SmFjMU16TVhs?=
 =?iso-2022-jp?B?cUZ2UGN3T2UwdE5oQnRaYWZtZkZ5Si9OSzdDL1FucXZxQzJ1RnNjbWNi?=
 =?iso-2022-jp?B?YVlOdFlNVFhSK3pLemtDQVJ1OU1wSGZwSWU0MU9BZ080SlBqSlRNYjl1?=
 =?iso-2022-jp?B?VjhJMXc5cElmUTlDZGtKK3U1WHNPL1I0QXFWMlpwTDl1alRSWjFnZjB6?=
 =?iso-2022-jp?B?TVpXcFg5cWxyajJUcE5wZFROb1NybmVXTy91eUhycEFvbnVZNU9SUER2?=
 =?iso-2022-jp?B?SDR1aWxsbTBiMW1YbStuVTA4QlB1ZnpFTUh4MjRqN3EyazArOGlEWEZy?=
 =?iso-2022-jp?B?SDlGOEM1Tm9LR3o2V3ZqKzRuSG1WWkVGV3BOUkl1bGF5MnhlM21XUWhm?=
 =?iso-2022-jp?B?Q3cwdDg9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB1107541F904CDED694538F4F2C740ATY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5979fa71-3e2d-495d-fe8c-08ddb935bada
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 06:57:37.5184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4USefX++LQ8/9mdD5bAZukWuQFzkOsm6bovkefaeR8zdK5cVXgylILlR+swcOJjBJjIfAiWHyEeYYLW99IPNA7Cs/MtPOSgROON85peYQs33wHZkuG6NcL1BYQUWz6c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15195
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 06:57:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19277

--_000_TY3PR01MB1107541F904CDED694538F4F2C740ATY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello CIP-members,

This is regarding the negative test scenario support for secure boot in LAV=
A environment.
There is test case to verify/detect the ROOTFS corruption in LAVA i.e basic=
ally dm-verity corruption.

The requirement is to modify/corrupt the .wic file in LAVA using postproces=
s action so that the secure boot will fail with dm-verity corrupted issue.

In LAVA, partition mount won't work as the LAVA docker container is running=
 with non-privileged mode.
When I created issue in LAVA repository [1], the maintainer suggested to us=
e libguestfs to modify a disk image. I tried using it but unable to modify =
because of Read-only file system [2]

So, I tried using dd command to corrupt ROOTFS as below (write zeros to sta=
rting address of ROOTFS)
$ dd if=3D/dev/zero of=3Dcip-core-image-security-cip-core-bookworm-qemu-amd=
64.wic bs=3D1 seek=3D157286400 count=3D256

After the above change, the job failed with below error [3].
"Could not find device  mapped to 'home' cannot be encrypted!
Rebooting automatically due to panic=3D boot argument"

So I'm not sure this is the expected behaviour for this case.
if this is the expected behaviour then we can write the test definition acc=
ordingly in LAVA.

if you think this is not expected behaviour then please let us know if anyo=
ne has any idea on how to simulate the dm-verity corrupted scenario.

Any input on this is very helpful.

JFYI,
In other cases eg. corrupt unified-kernel, the below command is used to cor=
rupt the linux.efi file as below.
$ guestfish --rw -a cip-core-image-security-cip-core-trixie-qemu-amd64.wic =
-m /dev/sda2 write /linux.efi "corrupt"

[1] https://gitlab.com/lava/lava/-/issues/671
[2] https://lava.ciplatform.org/scheduler/job/1286826
[3] https://lava.ciplatform.org/scheduler/job/1248737

Thanks & Regards
Shivanand K

--_000_TY3PR01MB1107541F904CDED694538F4F2C740ATY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello CIP-members, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding the negative test scenario support=
 for secure boot in LAVA environment.
<o:p></o:p></p>
<p class=3D"MsoNormal">There is test case to verify/detect the ROOTFS corru=
ption in LAVA i.e basically dm-verity corruption.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The requirement is to modify/corrupt the .wic file i=
n LAVA using postprocess action so that the secure boot will fail with dm-v=
erity corrupted issue.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In LAVA, partition mount won't work as the LAVA dock=
er container is running with non-privileged mode.<o:p></o:p></p>
<p class=3D"MsoNormal">When I created issue in LAVA repository [1], the mai=
ntainer suggested to use libguestfs to modify a disk image. I tried using i=
t but unable to modify because of Read-only file system [2]<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So, I tried using dd command to corrupt ROOTFS as be=
low (write zeros to starting address of ROOTFS)<o:p></o:p></p>
<p class=3D"MsoNormal">$ dd if=3D/dev/zero of=3Dcip-core-image-security-cip=
-core-bookworm-qemu-amd64.wic bs=3D1 seek=3D157286400 count=3D256<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After the above change, the job failed with below er=
ror [3].
<o:p></o:p></p>
<p class=3D"MsoNormal">&quot;Could not find device&nbsp; mapped to 'home' c=
annot be encrypted!<o:p></o:p></p>
<p class=3D"MsoNormal">Rebooting automatically due to panic=3D boot argumen=
t&quot;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">So I'm not sure this is the expected behaviour for t=
his case.
<o:p></o:p></p>
<p class=3D"MsoNormal">if this is the expected behaviour then we can write =
the test definition accordingly in LAVA.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">if you think this is not expected behaviour then ple=
ase let us know if anyone has any idea on how to simulate the dm-verity cor=
rupted scenario.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Any input on this is very helpful. <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">JFYI, <o:p></o:p></p>
<p class=3D"MsoNormal">In other cases eg. corrupt unified-kernel, the below=
 command is used to corrupt the linux.efi file as below.<o:p></o:p></p>
<p class=3D"MsoNormal">$ guestfish --rw -a cip-core-image-security-cip-core=
-trixie-qemu-amd64.wic -m /dev/sda2 write /linux.efi &quot;corrupt&quot;<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] <a href=3D"https://gitlab.com/lava/lava/-/issues=
/671">https://gitlab.com/lava/lava/-/issues/671</a><o:p></o:p></p>
<p class=3D"MsoNormal">[2] <a href=3D"https://lava.ciplatform.org/scheduler=
/job/1286826">
https://lava.ciplatform.org/scheduler/job/1286826</a> <o:p></o:p></p>
<p class=3D"MsoNormal">[3] <a href=3D"https://lava.ciplatform.org/scheduler=
/job/1248737">
https://lava.ciplatform.org/scheduler/job/1248737</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</body>
</html>

--_000_TY3PR01MB1107541F904CDED694538F4F2C740ATY3PR01MB11075jp_--


