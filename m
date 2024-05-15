Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ABBC25B75
	for <webhook@archiver.kernel.org>; Wed, 15 May 2024 04:55:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.7090.1715748950206715186
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 May 2024 21:55:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 44F4tlx03273466; Wed, 15 May 2024 13:55:48 +0900
X-Iguazu-Qid: 2rWhNMNecUgHB75IRC
X-Iguazu-QSIG: v=2; s=0; t=1715748947; q=2rWhNMNecUgHB75IRC; m=ERmHpCBbnA3LP11d2+QzKRtgvosNt+YK7nPLs3+8XuU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 44F4tjfF394487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 May 2024 13:55:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZe5DX+m02y6UHOoTXJhEvcaUE0CPyFR1qOZhEDs+OCrjwupvEdz6QO8Ups4r1gJ+GjEGJrh1/+BqxEoxIFchOcx3sOMMW6zsai+O6ha8V8Ckbs6dQUnC/fxLD2KoFrN8YwFD9sbh3F1OLK0iUximSKlJTaq33ZhXU7nq9aZAnMScqESdnALMmBxMAV/sU2oiNVeGQjQjH7Gk9ZmAZkiWBpJBhukJxFaVgUkqm9NKEurZdlKfT2rZj+TdRj+IOCyTxbLG7KrX6tiewOiT17PJOA2ongFixY2cs9Xqg+fJHFECwszVsujD6KEAqWs9gpBW2Pmk4/XJ6GxAldEfUDZ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0uqr/kAoRt3XZx6CcGx9lqJbCHMXZjlwIbAV5adFaw=;
 b=H9JDK9z9HLEH/s00PjRsrIlLgGhjvDdOxOmF3kT1TZqhOMu5bcsaDdyvbvFXHAYzHKlJtlTwvjAe7XNwGaq+SvWcw+nEqS+rO+Yb1/s8iXxG9SlKBPiUufTqtEmaktq3nxviI9u5ZL7wy03B1RFN1iSZ3BVca9NYVLwaRNP0vlKz/3PekcXMCwdORj/TfPH5sd288VUIzmQa5IlW2zC3sXSry83DqWE5/HHW0spVE1eis0i8tat8KneJ09bFv0XqN3HaGxsa95HdAHBY9YPBezfFIBQ7IbGU+jsD0nLMVo1Wo4xaWulcbPyD+NaHrkoHqo/XLYFHFTnRJrHuN3s+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Request to set new variables in isar-cip-core CI/CD settings
Thread-Topic: Request to set new variables in isar-cip-core CI/CD settings
Thread-Index: AdqmgelZjuWYB43CS9e3LFgjIYj0/Q==
Date: Wed, 15 May 2024 04:55:43 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB610309B1762500EE7829FB75C2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB7903:EE_
x-ms-office365-filtering-correlation-id: 0cba55ad-2378-4b7c-aa83-08dc749b46b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Qzh6dk8vdzJ3Umo0REJFU1M4aG1reElXaFQvMFFlQkE4R05ieGY3a3Vv?=
 =?iso-2022-jp?B?QjJGTnZ3ZXVBWmM1R3NGSDhuOVh4RGd0VUxwLzh3S2x0OVBYblZNRERQ?=
 =?iso-2022-jp?B?bjdjbmE4cjE2VzdCT1pVZCtTZzdqN2l1d3hKV1pnYzdMS2puZC9FN3ZT?=
 =?iso-2022-jp?B?YVEzTUlXWlNwSlhPU0dobnQwTmxmUThFYUhpSFdRdzNRRWdwdWtvU2pr?=
 =?iso-2022-jp?B?bHBLcllPcW5IZU1QQ3VwU3lhYWR6SGRIbENJc1VMUlJrM3lqTnVyUmRn?=
 =?iso-2022-jp?B?Qm1ocEtTNjNxbUluRE1BWk9aRnBrVTRFdGVHL0JiS3plVXNoMC83TjVD?=
 =?iso-2022-jp?B?NE9Pak0zU3JzWlphNDAyK3Y1eVQxZzEraWZZalR6NTIxWURkZG1jaGkv?=
 =?iso-2022-jp?B?WUxRSFE5SWdtZjV0UmZwZ1JxMXNUNWRyaHcreDk1eVRBbzU1R1J0REFL?=
 =?iso-2022-jp?B?UUlUS1BqWktaK01IdVdwOWQ3UkFRM00zRTVQNnFKNGJOdFNHMnFXcUlG?=
 =?iso-2022-jp?B?UUtneEdKR0dkYmtyeEo3ZTVnTXpxb09kelFnVmZhK3plVHloQlQ2TkRz?=
 =?iso-2022-jp?B?L24wWm1pakc5L2pGSWx5Y3REK0FCekNtN01oUmVDZmNSZng2NDEzQVV6?=
 =?iso-2022-jp?B?TWRSVkp4N3Z4bmlOQlp0RDU4Wlp0UTV5R0ptaVY1NnA1UXJTWko4T2tl?=
 =?iso-2022-jp?B?bC9ZeDdHRlpsWjNaT0dBNmhSYXExazhqTDFjLzNIQ3hRYjZhRzNjVkc4?=
 =?iso-2022-jp?B?MzZrTFk2WVBjWE9MRHE2dk1scHVRdE95VVpIZ2NJM1cxbGJLQmxnR3pN?=
 =?iso-2022-jp?B?eU9TeEU2V25Ya3R6VkVzQWZLRkxTSGNRdnhVUmtSaDM5eWZxa2ZVbS9L?=
 =?iso-2022-jp?B?dGZ2T1k4N2VGaE5SS29Td2IrSk41cy9FSm5hZVZPYy9xUEVnc1Vwc2NC?=
 =?iso-2022-jp?B?bmtOVzRBaWhlb1RoUlI2UXBIZXNFZ0dvNWhwd3kzTW5mOG9jTmhUSFh3?=
 =?iso-2022-jp?B?SFVVdHIvb0FBejhJOStnVzV2dUk1ajdlQWhlN0IyRHJwSmt4OWsxNk54?=
 =?iso-2022-jp?B?STlxNTJua3ZBZ3ZoeERPaUdlSjQwcG4rWDN5Tis3cU14ODBMSUQ2S1dz?=
 =?iso-2022-jp?B?cnZLd3U0alJua3VHdEl5TU44ck1HQW5DOVR1MTVnalV2VFdQb3FOanRv?=
 =?iso-2022-jp?B?dE9SVFZJeTg2TU00aFlpeU1pamVmUmNMRG1Pbk9QSy91U1Rkd3k2TDZH?=
 =?iso-2022-jp?B?VG1Xa3I3R1dHZnlPM1ZVUUxwbEZZbUpyVmVoTmtUVGFJaHhuRXJqVEFr?=
 =?iso-2022-jp?B?NEtFVTZmamNNMUpFWmpuVTgrUWJkeGN5K1F3bHdJaExCb1R2WGVoQVEy?=
 =?iso-2022-jp?B?VmkvbWFhdjJtV0dPVFNIcHVLUk9YV085aStpOFRUSmNqRWY3bEpqcFhT?=
 =?iso-2022-jp?B?WndhMUlubGtlOFJjQU5CbGxVU2tQalNaUDhpM0ZKL2VFNmMzVTAraHRq?=
 =?iso-2022-jp?B?cThKR2NnUks1RXlNQ1BKOVBEc3ZCbjZ1RVQwOHNUWHpqTGxmaDhlcnJi?=
 =?iso-2022-jp?B?aDFHeW1ZZnFZcjgyc0ZSM2F3VlFXSFh5UjYyZWpBeDd6L25SWk1ybERl?=
 =?iso-2022-jp?B?ZVl1QWIrQ013MlhWenllYy9SRWxHR3BMUlJ2QnRQTG5OZ2dyS3YwRVg0?=
 =?iso-2022-jp?B?NE9oME9vVFFYRElyZEVsMXA4d2E1WUV4a3RTTVR3NWx5WlltUCtrM2k5?=
 =?iso-2022-jp?B?aXRuaUNWOEQvRVR4eVE2SUtRZld6M2sxb3lHMW4ybnBYcCtDZ0FldGhU?=
 =?iso-2022-jp?B?YjVhU1huNlRoblBQU2Niby9mNkdUWC9VeW5IajlBdFVQaVJnaVJiQkxq?=
 =?iso-2022-jp?B?OTN0ZFJCaHA1SEVYSUc4VStMTm1rOFVkMkpDZG00cTRPc1ViSmk4RFJ1?=
 =?iso-2022-jp?B?ZlEzdWphUE5BZlBjRmZJdEkwNHc2QT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cHdyWXY2QWdwZjEzWVA2amlQVDk3L3kxYzhrL0pFNnVsb1VZVTQ4aGs2?=
 =?iso-2022-jp?B?TDlHeVVYTTlqaG1mdE8rbVBZcjBodjljTGJTOWsrT2pFSWk5aEc3bkkv?=
 =?iso-2022-jp?B?OWJwQVdKbVlFZEdPT2xEbFBBbWhPbjZQYnZwN0FoR25UMVJWckowd1k3?=
 =?iso-2022-jp?B?SXpmY24wVHl3WG9BdWtxa1V2NXFzQ0JGdCtkaHFCLzRlWWdVelhjM0VR?=
 =?iso-2022-jp?B?bUNuTjBoUUZ6eWptU2MwQnFhaWVrOW1YN0phWWYvMHNKckw0R20vVlFz?=
 =?iso-2022-jp?B?U2syVVFLaGl3QjZ0Z084SkIrZEhmblpsU2dUd3ZtTGRPMS9wc0d5VXlt?=
 =?iso-2022-jp?B?TFpQbGlRLzNlb0pNekVzYXA1U2lOd0hza1RWaVppU0pNaWkxQXZoZ1k2?=
 =?iso-2022-jp?B?bHlsVVpkYkpCTmI4NXVQS2lZRTBaSkR1N2VzZ3N5aVhmQytvUVUvS1Fx?=
 =?iso-2022-jp?B?Q3RGL21FYk14T29kdDA4dm85bm05NjBIMS9NbU9Ca1IvbUxYbUVCdmU5?=
 =?iso-2022-jp?B?MTJ5Q2hKM09DdWZYV0dzYXZZUmVJbk5ERHpvbXUrM0hYcDNUTnlnc252?=
 =?iso-2022-jp?B?ZXRaenhBMDlzN2tXc3MzTWxCWmx2K1d2V0tZTjlOREtlN1BiWmk2QmFB?=
 =?iso-2022-jp?B?UmR6aktSVzlqbXdpVm1CTXdqSWxNY2QzTHg3TGwxNHRBNUhad29TY3p0?=
 =?iso-2022-jp?B?M0hOSnhJRmtGa2pvYWRpcGZrYW5TcktuVG1BK3FMSGdqVm1zUVVaUmd6?=
 =?iso-2022-jp?B?b0haRGl1MytkNkJmTURqZDNQblp6am9nRUNoSDBlWFV4ek9BOUJLQmYv?=
 =?iso-2022-jp?B?L2hOMmJkS2VsQk9NV09leHpja3JtMWNVNkRsUkdmN1JFSEc4bXdGMGFh?=
 =?iso-2022-jp?B?eUZWdGsyMndOV3pjYXIxUG1sSndheTU0RCtmc3VtZFZYKzQ3dTBhb0Ju?=
 =?iso-2022-jp?B?MEdvK01PY1RFbWNPRmVweEZQdXgrZWFRSjRiV05ONURkTnVvNk1RTjJY?=
 =?iso-2022-jp?B?YlplMEJncGtRL3NMUGF5RWxOQ3BxdWpNYWdUUjdHblkzWGRTNi9TdWJF?=
 =?iso-2022-jp?B?ZU8xTXFzZGFJNEErL2UrdUNnTk5IcE9BNlFpK1dSdDJzN05sOFJYMFpT?=
 =?iso-2022-jp?B?RjVJUzBJUStQMWhqeHJQNWJ6Zjh4WDVwZERlVlh1SUFIODcxNEc5VXpV?=
 =?iso-2022-jp?B?RTNMd2tISmFaQjRZRm02MUw1UXk2RnFLM3VwSVYycWQ0RWVtbDZld05L?=
 =?iso-2022-jp?B?Y2RYT3R0dEwxdDB4L2pMWWZDN1FKRlY0T0ZnVjhhb01aSEpPeXpFaXA5?=
 =?iso-2022-jp?B?MVJ1TENsL09yZVhaMjNqOXlreWF2Tm5KeDZtM0taVG9LWmZpNHZHdlBG?=
 =?iso-2022-jp?B?QUtwRzFzV29objFkSjY5RkVqR1BRTzJ2V0luY3lxMGVFKy9iQTJNQm1P?=
 =?iso-2022-jp?B?ckpvWWNUajlQYjZUcVRORzB5ZWw4Z2ErbURMbnppbFpkQnVRUlpaUkVY?=
 =?iso-2022-jp?B?UDFCc3M5KzNYaXlmUGFJSkJ5Tjd3VG41WjdEL1VkWVJLSzk4NUU2NGxS?=
 =?iso-2022-jp?B?UXV3d055VUpSd0NkbmpSM2szTHU4eXFOR0trYkJIRVduR2l2YkZXdU1n?=
 =?iso-2022-jp?B?SjZodkVCK2kyNlVZZFZIbXhjU1pXTUFCL2xRYUpWQUFKbGIzQzlkTGNK?=
 =?iso-2022-jp?B?M01sNjBIUnduNGxvSDBvVXdyYmhuY1l2SXFSenZKekk4ZjA5VzNnVytl?=
 =?iso-2022-jp?B?eUxIVnh5Yzd6ckJJWStjWnpWK1V6WnNKam1JWi9rblp6WmNsaUxPOWpp?=
 =?iso-2022-jp?B?RTFuV0daL2FZd01ZdktSS01SUDd6akQwcVQ0MElMVFMvKy9SeGNXRDBM?=
 =?iso-2022-jp?B?a1VDb2hna1BVZnFJVHNJQ2E2MHc4UGhXRVZVVTVPNHFNbHUxTkRyN0ow?=
 =?iso-2022-jp?B?c2p5emZFME1IVU4zTG4rL1ViYnNFVnpyQUpXUXFtd1RHNDI0emVRcEY3?=
 =?iso-2022-jp?B?QlNITS9jS1ZUV1VWRDJBNzlMWWdsZC9ieU1NVjE5eEpSQXBRMUVwSElM?=
 =?iso-2022-jp?B?Q0p3K2VDY0J6d0Iwb0lsWlE4c0pJaTRpRGE5cjBGSjJnNm14Rm10MWU2?=
 =?iso-2022-jp?B?WnVsZ2RPckNsbjI4SnVwZVN5OWFweHVFbUlCdmFrY0RpTlorN3Bxb3VG?=
 =?iso-2022-jp?B?KzFNS3ZYYmY4SHBKUERWNXUvK0ZtSDdRN1N0VGgveUJpWWRkVUlLSmN2?=
 =?iso-2022-jp?B?bjB1VVdnOTVuR2pxRzhrRVcyM2IrbFdjZ1dmZHlUSjUrU3k4NUNITVBr?=
 =?iso-2022-jp?B?eWRZZ1kyNnFvMEdLcDZidDRQajZ3cG9CS3Y0eGROcU92amRxSkdRSTFC?=
 =?iso-2022-jp?B?ZmUxRXZrdElYUEcwalVlMFk0TlR0N0xxY0g0cHF0KzZlNHJwdVdBK0x6?=
 =?iso-2022-jp?B?YURuNEdBPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB610309B1762500EE7829FB75C2EC2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cba55ad-2378-4b7c-aa83-08dc749b46b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 04:55:43.4608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lO2wkornZNnLVO0X8K8P2z0HpBELpRhjH0EIg+W73yOweX2BiKTvMf4d8rVSExmXUueCR33VXwlfmfMc6CZ0tL2YR9Z+QRpxBDX4vuIRLwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7903
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 May 2024 04:55:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15894

--_000_OS3PR01MB610309B1762500EE7829FB75C2EC2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

Currently I am working on a script which prepares and send LAVA job definit=
ions to CIP LAVA server whenever a pipeline is triggered in isar-cip-core. =
I need to use below mentioned variables which are required to run my script=
. Since they are token related variables (lava user, lava token and squad t=
oken), I think it is better to hide them in CI/CD variables section.

If any one with maintainer or owner status is willing to add them in isar-c=
ip-core, I request them to reply to this mail. I will send them the variabl=
e keys and values.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)




--_000_OS3PR01MB610309B1762500EE7829FB75C2EC2OS3PR01MB6103jpnp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
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
<p class=3D"MsoNormal">Hello everyone,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Currently I am working on a script which prepares an=
d send LAVA job definitions to CIP LAVA server whenever a pipeline is trigg=
ered in isar-cip-core. I need to use below mentioned variables which are re=
quired to run my script. Since they
 are token related variables (lava user, lava token and squad token), I thi=
nk it is better to hide them in CI/CD variables section.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If any one with maintainer or owner status is willin=
g to add them in isar-cip-core, I request them to reply to this mail. I wil=
l send them the variable keys and values.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB610309B1762500EE7829FB75C2EC2OS3PR01MB6103jpnp_--


