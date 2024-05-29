Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02389C25B78
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 01:29:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.3286.1716946174175374537
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 18:29:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 44T1TUcb1628689; Wed, 29 May 2024 10:29:31 +0900
X-Iguazu-Qid: 2rWhYYPQFE0a3Tckw1
X-Iguazu-QSIG: v=2; s=0; t=1716946170; q=2rWhYYPQFE0a3Tckw1; m=M5yvnPYqcgla7JsRc4E85oXWq2DWCe+4SZmNLALJZqs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 44T1TSIe211974
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 10:29:30 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjWKqkYy1xBvgeohyTgRwYiAMfQ7cUL617e8wyHMFwgjhaKy2DNv6ZNpNE4JoT3Wee1PtzDve+brIwXLEzijYkA4WJSfYg2Dlx8bPUWUoBc+dfkmyXgkzRGm2PiVBIgRNQaaSme0L0kTlI9E27maNahM/xSLndyLFjHZPi6bwjzeLqKIQkkusWyG1gB83kIZoBIFwAHYZVsv8zGrxxTpo5iuT8jwitzFRu8J6+1jmeE11aQucEHRbDv81fE4guJ256KxaW7vC92NYQSi5wELobSKVKhoUuWeKHjGvghZL/0WJ+kkfNzPG/TEr4xK7xMidWknpy9+Dx7jftkiydF9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvVRCNX14ehVstL0nUfA8MkXhmCVc77/tCF4IdpOGog=;
 b=XcLabQgfA6IteCOAy4pcA7WWfNKSmhpHdfphuEDpQLzMil1fYPhQfHsEbEe1KqKNtge8jR7SZQt/vY2Q7f3c9Orp+7GGf6TpvbQCUoMXIcoiC9WDrA+ccVXZMHiSrGrxwIZAOHO8F8jel0I7orT+o1rae9WetmefB1zZSlesaa4ZFUb1D85yB6rmwIoi9n1QzNHWeBaSgvKIDZ3hkqp93xIcM2L9odJl5Am+ZUJKtZA41WShzszo1MOgkpG1gU60tFTuE0KRsamGjzopkGqh48WXbxdgFLdzizQ2n6fYM3UBlONN1wghErV+5Zz7d3fQXwCTY44p7+Ope9GrzcPRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: Unable to start swtpm_start.sh
Thread-Topic: Unable to start swtpm_start.sh
Thread-Index: AdqxZjRcYVHYPZxaT7+kSAcinUMJhg==
Date: Wed, 29 May 2024 01:29:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610382522DF0932C7EB0CEB6C2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYAPR01MB6026:EE_
x-ms-office365-filtering-correlation-id: 6491e5c6-ad2e-4c99-0a85-08dc7f7ec758
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QnBGSEl4dkZpVU1XbjRHbkl3bnpZV1ZaOEJBTnFHKzlZVG1RYmYyeEpX?=
 =?iso-2022-jp?B?anR0d2pUSjJ6TDczaUtzSlIwUmNMSXNTY2hnY3B2TERXNUdmSG1qR2FJ?=
 =?iso-2022-jp?B?Vng4RVBwUEtsUDJ2K3BvMGVjYmh2ek8rNmgzRWdLMjAzVWJQcHlmZGpu?=
 =?iso-2022-jp?B?UVUzTE1CZUd5YTVmUFkyY2YxZnpsTDBSNFNRZGRWN08rRHNCemIzVzlH?=
 =?iso-2022-jp?B?V2NiZWk0Vm54NTdiRWpYd24zc2VGUEdjWUVieXdZWnZ6UHZIbzF4QzRY?=
 =?iso-2022-jp?B?aTZNN25UNFJPNTIybEVuSDdFOXoyZDl6ditDaUJObjBjTk9mRlI4NUR4?=
 =?iso-2022-jp?B?dXNZa3NnUWd0N3RZVkFHRnl0cUdBK1A4aC93cE9KUWs2dUhQcmtVUVJ4?=
 =?iso-2022-jp?B?SlFzT29zaFlYd2hhbkJvUG5tRm9IY0M1VDFMOHFSdFR1NHIwVEc5QlB0?=
 =?iso-2022-jp?B?VHNCSkRmU2Eybkh4Z0RoVkY5VVBCR2VERlBibTR4RmlXWW13ZHo3QzFQ?=
 =?iso-2022-jp?B?NW1UOUE0dTJOY1A0Y014TUR4QkFFRVFSdXNkQkpQWjZHdGpJT0poWTBE?=
 =?iso-2022-jp?B?cjVIcGdXUnF5RHFuR1ltaGsvZG9JYW5MRjFueUhGREFGVitrcGE4emMy?=
 =?iso-2022-jp?B?aDRrU3o0ZFFaallCSi9haDdabmkvZ3pGcmxMSk1XZkdmaEcvSSt3aDIr?=
 =?iso-2022-jp?B?aE1jYmhCYk53NmEwajkwaE1kc2J5Z0RxcmszYWtmTy9sYlFJalVmRWdH?=
 =?iso-2022-jp?B?Nms0Zm5wNWFqMGRTUm5uazRpY040TjdGd0JtZW12blJ1V01DeFBIRHNZ?=
 =?iso-2022-jp?B?MWFCYU4wMVBKaDhKVUNTeGhuT1VLZWpBaWNFZWZoNGxpTU5VWmxick1j?=
 =?iso-2022-jp?B?N3kyeTA4TDhIUzBUdnA4aG9DaWQ1SzRteEhWY2lwazBtcVpld1g3VDlC?=
 =?iso-2022-jp?B?MUFBdDR1WnJCczdSemIvOXJtQ0VCZnVWMEtpV2FxbkEwYWxrajFBOXg5?=
 =?iso-2022-jp?B?UitORHEyQ2p5YkVndHUrR0dPaEpiMGFNUkhXTHArTXdIM284YmFEamdQ?=
 =?iso-2022-jp?B?OVdwSVlMcVMxTkhlc0pwUGVqUUZ0K0dTZ3NHMURpbmFLVjNtL1JxZVNI?=
 =?iso-2022-jp?B?OU9IT1JlSVcxQ1pvWm14U0hWSFgzYmRseFF4ZlV3OGN4dlZCTTBQbkJl?=
 =?iso-2022-jp?B?Q2ZKd1h3OHZZcmpPTCtSQStDSlBscUs0T0JseE9FNkxESjRZd0xUV0w0?=
 =?iso-2022-jp?B?YjNnVEtCN1o0MkxyUjNVYUMzTkNUeG5iMnpmR2dKVC9PM0FHMThjN2pW?=
 =?iso-2022-jp?B?TnhvRzRCaFpWV2tLd2tUdUtmNnJ3RU0wb0lwRGJ2eU5KWE1kT1dOdTRi?=
 =?iso-2022-jp?B?bjhCSGM4UnkrTkZTQytqOCtEa2V0MWxNMUY1WFU0RlVJZW1NS3NHd0FY?=
 =?iso-2022-jp?B?UnFmbk1VamxxT1pCSDB6cXRIRzdXcExvdmJKYVRweEEzT3c5VGp5a2NG?=
 =?iso-2022-jp?B?TVVMTlMvU3NicmtETlJMZWVHdkZCemsvdXZxSDUzVDh1TTRkZHNrZmlw?=
 =?iso-2022-jp?B?UU1zUzZkZ2VzcTNnaStiVzhYSSs4Sm9GVGlzVUtvUk9zeG8zdm1mMVph?=
 =?iso-2022-jp?B?SHAzbjVtNTR1akVqSzhHVnRucWNLc2NRYVh0Mk1HUFVIRklLZzVMTHdh?=
 =?iso-2022-jp?B?WUttTkJUVUhUOFQ4dGdQMUwrOUNST1NNU2xkOGVrV2E1YktQY3l5QVNE?=
 =?iso-2022-jp?B?YUFTM0dDN3FpSXJvSndiR0NzR3BXRzVmUEpkMjA5WWMwTUMzaXU0Ukhp?=
 =?iso-2022-jp?B?bzFsWWZibFd0M0ZxeFFSMVNQYVJ3QVNyaTd6VDJ1OU9lQzBUOU1IVXN6?=
 =?iso-2022-jp?B?OEdjYVFabGxkNjJZRHJKMEZ6aGpJPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VUNMMFo3eWpZdWhuVFlVdXd4NlBCMkZGWFhtdkRkZFJlb1lKNks4L3ht?=
 =?iso-2022-jp?B?d0lydXVGS0lDam5nK2diOWpPcHBLVXQ3TllreUI2NWY2ZDlnUVJId00z?=
 =?iso-2022-jp?B?aDBUNzNaN21kYzlJNHFpanlhekdCODFFcTZuN0ExUmJSWWtHSjBqTmJS?=
 =?iso-2022-jp?B?Qk16aU16TlJkNzFZaWZoNmI5STZLeE9uYXRNUEw0R0pqMDhoY1kxbkp6?=
 =?iso-2022-jp?B?MjdiUDhESlNjN0xjd2ZHdVJ2TmZkZHJXT1J4WFI5Zm1Ka3I1M2VBQ2pL?=
 =?iso-2022-jp?B?UWYvSUdWRE8rQVJya3RaK2xabWZNR0h2eDdpRytLc1Y0ZFQ3c3dMZXp5?=
 =?iso-2022-jp?B?SEV4R04wV091bDZjR0VEcjErdVRoT1NOK3c2OVYwZFNxQTVrdEtCM0FQ?=
 =?iso-2022-jp?B?VytVUEk0b2RURXNPTWh5RU5mSzlicjFTalZzQ3RHS1dkYWt6cHNMamdS?=
 =?iso-2022-jp?B?R1BUNS9hYWt6UHI5QjVwNVdjUERHeEgrRmZqZTcxRUNBd2YvRldublZr?=
 =?iso-2022-jp?B?Rk5jOEpYSXRuejNibkxYV1dveVBBOXpNRGdNMzFqSzU5Nlh4dDM5U1NK?=
 =?iso-2022-jp?B?T2RKVTJWOGQ3b2Y2SVFOTVVteGlXNm5qVGxHMld4SEhKZjMwZ3NNT2J2?=
 =?iso-2022-jp?B?dFArS05tNEo4dWdmWkRZRkt6V1JpbUZKck1xSmtqWEJQU0kyVkJZSzVQ?=
 =?iso-2022-jp?B?Ni9talhqQ1Y2OVJrVzFLMzN3aXJSYXllb0E1L0JHOU9QcmdoUm1IeFVM?=
 =?iso-2022-jp?B?UWswM1RnSVFUbW81T2lzbkFIUmpjWnN1Q3NiWjM0UHhocmFmMG5maENj?=
 =?iso-2022-jp?B?UkxOK0VHa3RWcCttSjNrUm1nT1VEUy8xUldJRVVTdHRpTFVmbVNRakt5?=
 =?iso-2022-jp?B?ODVSNXZERnlzeDF0MllKVlZtRWNGVS9qSHZRMGI1M2FGMDdOa2RrT3FD?=
 =?iso-2022-jp?B?WllhQloxRFFtcG14MU1wcFZVa2pURjNrMHFTVXphWWN5TE9LenNuNzJ0?=
 =?iso-2022-jp?B?ODh4WWZDS0xMUFNzZlZGNE1tK0l2cU13WS9xQkpIU1BNcjdRUXVLNU5o?=
 =?iso-2022-jp?B?Nmw4M0FsRTJobmNocVRvb1VGYTk2ZUV6eGp1SWNVa1VVdUdHcFRYNkpC?=
 =?iso-2022-jp?B?RVk4TldBWHJOWXdqQjR3dmJUWHdEeG9Fcys3dVNjREVnV1R1b3paS2RQ?=
 =?iso-2022-jp?B?ZHQ4cXoxU0lPZ1VyZG9CQ1FSWFBwazU5TUU2eU1iUllsVEJpbTJidGJq?=
 =?iso-2022-jp?B?bDRnQ2ExMkx4Y05JTzRaaGpyRi9XbDM5VHA3Sk9QVHN6d2FnL085ZENT?=
 =?iso-2022-jp?B?dElVWmlVOU1DdnlTNzBmR0VVcGRON2F5T1l4RE8yWU1xQU1MMnRJY1hp?=
 =?iso-2022-jp?B?ZmlVa0lNb0hwMnlhSThWb3dKUzJvVmE2dG10OWwwcm5ZQ0NCMzF6MWlN?=
 =?iso-2022-jp?B?UFpXL3hTSkhObDR5cGRGQU5jam5NSVpianNXejZsT2NPUVRMeUN0UUMv?=
 =?iso-2022-jp?B?cU12aDFmR3dkUkpBN05JbXl5c0NQUW9sRUxETVJVSjNpS0VOdG5pc2c0?=
 =?iso-2022-jp?B?V2lMNUVRT2NncFh5YWNvOGltUGVHSEE2TG5UNWttc3NUNVlPR3JrU1dh?=
 =?iso-2022-jp?B?VUpxVlY2VFZVbkxWRGpPV1V4SHFZb0RZRXlKaFJrcFl2Qk45TDJpc0pj?=
 =?iso-2022-jp?B?OWRSMklpMjJOd25vRVUwdkNWVFFwNEJGcVRtSGl2ZlI4UXAvendTMTZM?=
 =?iso-2022-jp?B?K1RSaGFNZ2VyRzRwQWtKSC9SY1BPQzJjaTRmNHI4SUZMcmZwb003dmNx?=
 =?iso-2022-jp?B?UXpuQkxVbTBhQndoUCtJY2s0dUhKTDBTd2w5VkhlQ2xkcWNMbGtUWlY5?=
 =?iso-2022-jp?B?anRJVWJ6VWdLSnB0bmdFMHpPVG5jSEdlaTdkbHowQkJuRHY2OFJsZDRp?=
 =?iso-2022-jp?B?aDE2Um51bWNNancyWGI0Y2tjNWV4VTU3d2wzZGNBVzI1N2l6N1FUbnFh?=
 =?iso-2022-jp?B?WnBEM2tCTyszUWtvN0xPNTRaakhmc0I4Qy83NzJIcXhwWVNQRlV0Wmty?=
 =?iso-2022-jp?B?SVhaS0I1NGVVRjFvaFMwK25YM3UzOHhZQ2tRVzUrTitNeWVXSzVSZkk1?=
 =?iso-2022-jp?B?QmJXR25KRE9MbGJ3NktzUmZCd2xKUFZKV0YvanNKTlh5Tk9wV1doQW9Q?=
 =?iso-2022-jp?B?OHRCcCtmaUI0VDFHWW5HTmlqaCt0SzBtMGp6Mnd3T3I2Um93MDhEcldX?=
 =?iso-2022-jp?B?R01jdFFWa01adVB4bHFzQ0ZHL1cxOEN1d09vd1hCTG9oK1lRVDBpa2lz?=
 =?iso-2022-jp?B?UStaTUtvMGpucnN3Y2p1RVhvTHZVZ29qVk5GQ08vWlREbEJqVXdlbEU4?=
 =?iso-2022-jp?B?MlpkTHk0YjhSMnB1K3BxNENvL01RR054NXM1bHpiQi8xa3lzMU0wMXF6?=
 =?iso-2022-jp?B?b3lHdjh3PT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610382522DF0932C7EB0CEB6C2F22OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491e5c6-ad2e-4c99-0a85-08dc7f7ec758
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 01:29:26.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nXFjo5lG7llqCirMrZ5nZfYRoszC2tjt3K0ryRdZuisbYS75L5/t/ZEOkdJ1QmjqsmcZlIYVdr7qGPSAYmh1Q1ZlL6izhXAeQs666afkoRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6026
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:29:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15977

--_000_OS3PR01MB610382522DF0932C7EB0CEB6C2F22OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

After the scripts were included and device dictionary changes were made to =
qemu-renesas-01 and qemu-patersonc-01. I tried to run the jobs, but swtpm_s=
tart.sh  is unable to return 0 as it was doing previously which is making t=
he job get stuck until time out. LAVA | Scheduler | Jobs | 1139794 (ciplatf=
orm.org)<https://lava.ciplatform.org/scheduler/job/1139794> .

In the end it is also mentioning that it is an infrastructure error and to =
report it to LAVA admins. For comparison here is a successful job which ran=
 recently on qemu-renesas-01 with your manual changes. -> LAVA | Scheduler =
| Jobs | 1132059 (ciplatform.org)<https://lava.ciplatform.org/scheduler/job=
/1132059> .  Previously in your manual changes to Renesas slave, there used=
 to =1B$B!H=1B(Becho $?=1B$B!I=1B(B instead of return 0 here https://gitlab=
.com/cip-project/cip-testing/lava-docker/-/blob/cip-lava-docker/lava-slave/=
scripts/swtpm_start.sh#L18 which made swtpm start successfully but that sho=
uld not make any difference, right ?

Do you have any idea what can be the issue here ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB610382522DF0932C7EB0CEB6C2F22OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
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
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After the scripts were included and device dictionar=
y changes were made to qemu-renesas-01 and qemu-patersonc-01. I tried to ru=
n the jobs, but swtpm_start.sh&nbsp; is unable to return 0 as it was doing =
previously which is making the job get
 stuck until time out. <a href=3D"https://lava.ciplatform.org/scheduler/job=
/1139794">
LAVA | Scheduler | Jobs | 1139794 (ciplatform.org)</a> .<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">In the end it is also mentioning that it is an infra=
structure error and to report it to LAVA admins. For comparison here is a s=
uccessful job which ran recently on qemu-renesas-01 with your manual change=
s. -&gt;
<a href=3D"https://lava.ciplatform.org/scheduler/job/1132059">LAVA | Schedu=
ler | Jobs | 1132059 (ciplatform.org)</a> .&nbsp; Previously in your manual=
 changes to Renesas slave, there used to =1B$B!H=1B(Becho $?=1B$B!I=1B(B in=
stead of return 0 here
<a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/ci=
p-lava-docker/lava-slave/scripts/swtpm_start.sh#L18">
https://gitlab.com/cip-project/cip-testing/lava-docker/-/blob/cip-lava-dock=
er/lava-slave/scripts/swtpm_start.sh#L18</a> which made swtpm start success=
fully but that should not make any difference, right ?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Do you have any idea what can be the issue here ?<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB610382522DF0932C7EB0CEB6C2F22OS3PR01MB6103jpnp_--


