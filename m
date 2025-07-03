Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF106C77B7C
	for <webhook@archiver.kernel.org>; Thu,  3 Jul 2025 01:31:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.12478.1751506286968904793
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 18:31:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=KPwIh79V;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1751506275;x=1752715875;bh=svqeVFJNka4l0n0CmMoaa4Z1WrV3Oh2vzMW8rkq
	jcCQ=;b=KPwIh79VCeD6b37pSTCLdwqvyzoDE/DT7wocefO93xXAtTfjsZltk1OnU9aLvZcbU0vb8
	tvX95ngCofMQJw4j+8ohgTypeN5yuzky49yXgxoAmoUmng8xQBYNIRH8ZXr3FHBIrgey8o22FzI2c
	QsbTU6AdH/nMs8oR8CwKHPpg/JUmzIa8vJGC9oEY1sADVf3GzZK3N5/pcmG5+bhh5/9Y5x5c5YfNk
	za8pJEd35iFSZsCOGALQEVHxDUxIf2xvKf5G6+jb4nQoeffZUln6R/ph7A3DrIc5Yhes6yYf4+WwL
	OsFLP5i2si0J/XChLZBZXh28ec4KWqRVpKX0wYsToQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 5631VEsq941355; Thu, 3 Jul 2025 10:31:15 +0900
X-Iguazu-Qid: 2yAbpfLvJCz6oazAmf
X-Iguazu-QSIG: v=2; s=0; t=1751506274; q=2yAbpfLvJCz6oazAmf; m=A8q6WtbtOa1Fhb/DoY7fOKaWTCWPmukqJ6Hu1VtPgO4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5631VDF71010292
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 3 Jul 2025 10:31:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mJQUcLqYmvpSaxjf/JFOUn9qXs63t3oECWp4CNf2l9BjOGdn8PyIfRAvDtiKNi0cdjIj9lAijWgmoF6F4t7DTpUdNlcdnXBsXdalislN0Ut4kRtYeWqnecef2NIbursMH7DY+bMIPZwGYxBVHNn+ImRY0APUxjxcl/6mlzZ7vwdQ5/3BtSNQZ+9mob+czgrRNou6y/Wpqgy/c9UaFqz54vUOu9yV9VJGzYNFUEl84M3bIDwMAygeZpVZ9qZiUoMN/UHZV4+ePYHtz4Kco4twvf4w+YcGfF9gV7SzQDwzj6OjPif0Si3iP5t7ZCXPTROEWB/jPVhrrkMb4SaGPF7Hpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUT5koI58Lr2JkTPxUY7Ic9f4dO3YQkYF17lekxHROk=;
 b=FXYfpMKx70EEBYOLUmidO30UIKSrm/bp6rsS4eeOASXvkZ+n5GpzUxaFrTKjCRcG8MJUGffqSSVZdAF8CmI0RQwzgkD12BvjlPkYWlP2zgEMpqPvi31PwQ0q7Lfh4SDKoRCxNalq5kV08EpalnZ9yz0dcH69m1hm3wxeCDg/CA8LEV5BnOHiJazbxiuV3C4JE25ZhH21v5j7X6Aj32um7lJSzSIKaxcFPwU4OzGdHAhWqFEWsXO29Uq+iQQenCM65UVxVPDn3wjnERbu9YzXB+IphsOfevsmxfngFHO/Dm2BE+e+frLF0bPj0QhfRGnd5R0aNou20m2X4sCBxseavg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.12.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Thread-Topic: [PATCH 6.12.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Thread-Index: AQHb6z1Yyvl5PcD/KUedHx9bgZzr1rQfna5g
Date: Thu, 3 Jul 2025 01:31:10 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818D02E5540125AEF41103A9243A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSZPR01MB8340:EE_
x-ms-office365-filtering-correlation-id: 35a12245-cb65-470a-81ce-08ddb9d14a43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?QnRiSTdEckczMWpENndpN1VwVkRGUGFicVJqZ3p4cmVEM3FXSHRBOG9x?=
 =?iso-2022-jp?B?YnUzeGVSRTkzblVnOUNncXNQdXFZSWNXcXVmQlRHWlNzVER5eDM1VFo3?=
 =?iso-2022-jp?B?UWV0djc4SFl3dEtYK3dsa3U4ZWlXZ1lCcklXbmtpQ1dTVXc0eFdzbVdr?=
 =?iso-2022-jp?B?ZFRFa3JuR0ZmbityMCtRcnFlWlpDZXNiT0FHN0JwQUJNQkVkTlAxb3dZ?=
 =?iso-2022-jp?B?OXlhTTRpSmtsOXJMeC9IZkhjK1dxZUlEWlFqYmdMNUZ6S3VRaFNtbklv?=
 =?iso-2022-jp?B?ZXFRZWdUMjRTY0JXZjIrRWVOVVh2eXVsMG52akNMVXh3d2M0MnNqblhE?=
 =?iso-2022-jp?B?QlVSK0VLOE1WcW9rcHBNQ0w4aTFuc3ZLU0JoTm1yOEJuWW93d09DMnBT?=
 =?iso-2022-jp?B?QTlEaVZpc0ZjRUROYWRTbm9xendwUzdCMHBVWk9nVnBFcVAzYjlPTGpm?=
 =?iso-2022-jp?B?QmViNlNMR1psVXVIWjEzL2VBdFlwZWluSjFNa0g0dzlVS3F0VTl3b3J3?=
 =?iso-2022-jp?B?UWdNTkxkQ2g0dTdBV3FCUnlVcElqSml5U0F6eWQyRU10dEZzS0NBQnB2?=
 =?iso-2022-jp?B?Q0NWT2ZGbnZ1Y2pSc0lrcTFIczBpY01Ga0tmemtVTmNBNUR1cHNIWE52?=
 =?iso-2022-jp?B?aVFsVTRLemNxNERaYVNBY0JzUHBFcFZ5anJqUXFkdnYrNTJOSWFWZzVE?=
 =?iso-2022-jp?B?NWdQN21WRlJSd1hmLzlEbHNOQ0JDQUNsUkVvem82Y2RZWERnSGF2cGhU?=
 =?iso-2022-jp?B?UDh2SE9kUmd5MjRjUWJISnpoejVIdVFLdW9haXZ3REd4NEtZRkxrdUJX?=
 =?iso-2022-jp?B?cEdQbjVqNTJuSGxIMHJYSUxhR25iQndLNVZHdjNUT0xvZktXajREYno5?=
 =?iso-2022-jp?B?YXA1amtucDF4Q3QxREpyL2VtNnJUZUdBTTg0aTQ4aGYrWWkyN2RWOUNq?=
 =?iso-2022-jp?B?Z2NpYjRDTTdEZlpwYWVJZHhLN1oxeXp4Zm1DeThMNm55RkVJSWlQZDJz?=
 =?iso-2022-jp?B?RmlFMnZFdWJQNWtYcGtpYVp6MFNGSmExWDJURUJKSU5vSDZMdlBsQkxt?=
 =?iso-2022-jp?B?Z2ZSalN3Mld5VTgrZ1FiQTdqalJEM0F4SUttTVBEMVBtVUl1d1FTM0xW?=
 =?iso-2022-jp?B?bHhkL2JLT3FwcXZhZmo4ZG1CQThlbkovZ3NnQ0lvWFk0dW4yT1NrTUxO?=
 =?iso-2022-jp?B?RWNWZG9iK3Z1Yk5ZRWNnb3hrNDA5RTg0b0xIQ1l2WkJ4Ny9kWW81V29I?=
 =?iso-2022-jp?B?YnQydXYrbkZLYTFlY2ZLMElweDZlSS82M2RGc2FkWlE1aWZQenFPWmtw?=
 =?iso-2022-jp?B?ZkRzVzlpcXlKMGJaK1MwMHl5WTVvenFQQkJqNk1KNTk2Wjc3TWdJcmxJ?=
 =?iso-2022-jp?B?Vms3Z05nRElFeEtEcVpuaUhaOTYySjNlcE45OGJxZWpXVW1vRURnRUlT?=
 =?iso-2022-jp?B?Ny9MWituTDh3amcxNXFMUHVGMDVWZGxBWXVSdTNsMW56Skh0L200YkJN?=
 =?iso-2022-jp?B?MVd2RlNORXNuemhleldIYXZubS93bzZINmlYTjV4OHVhemZQK3Z3dTkx?=
 =?iso-2022-jp?B?aktaSi9ncTgvQ2wyWWRLQ0lNYkJETFBXbmRNMzB3R0Z0ZmRkVERXU0dS?=
 =?iso-2022-jp?B?UUtuRjFIaEVoejJUTHVTZTYrZTdGN1JiNUZja2R4cDAvaUEzWDc0T1dY?=
 =?iso-2022-jp?B?ZE82LzZzVU9VUjJoRlpVUzVOekQ4VTlQKzZZK0Z4TjlMd2h3U08ybU40?=
 =?iso-2022-jp?B?dERPbWJLWWRCaWNOVHFlN0hUTmpuVWhUeStSc1IrRDFNdTdxVGlmci9Y?=
 =?iso-2022-jp?B?cnY1UGZLNGRYRlNOVG5DWFo4aSs4RVhwVDd4bmZxV1p3WlVGTFd5MVph?=
 =?iso-2022-jp?B?SjdWU2ttM0lpbEVhR3VZZ0NUWDJvckl2RTQvNXdTSUljTThRQ29mekRJ?=
 =?iso-2022-jp?B?YmR1bm1LMzNmUXZTdzFvUHZlNnJKNEJ4ajRwSXZJSy9SNUJKbUpmdkU3?=
 =?iso-2022-jp?B?by9Rd2l4Qmh2REVRd0o1SUdKUnlaZThiaW9ENllCY3I5amloS3BWcEor?=
 =?iso-2022-jp?B?WmJqTm02UXh5VGdGNE0zeHEzMS9OQ1A1WVA0N2NzcXZVY1BnQnE4S09s?=
 =?iso-2022-jp?B?RnVETWNyTVZRLzY1UCsrZCt6bUJZQzdxRzdGTVpiYzRDVnc5Rm9yZWNB?=
 =?iso-2022-jp?B?cUJVPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?cUZPbW9rVHBQU2pJWSttOXlacGdpNDlxUDMwY2xtQ1liNTVVY1Y3MzhZ?=
 =?iso-2022-jp?B?WGowV2VSK0xTcVorVGNSWWlpTDV1RXpxTk1IUjhSUnBmSjd4dEl2VlFQ?=
 =?iso-2022-jp?B?MFZBbnFYRU5jR3FIdEYwMmFkT2FhbmJHTDFLNTlTNmZldTZ2bEp4RTNF?=
 =?iso-2022-jp?B?S1MwTXRaeGVzNDZvSWYwb0Z1UGNHc0hDYzhwVnhPcDFUS0IzZGVxZnY5?=
 =?iso-2022-jp?B?T1IxNVVrbXFYaFVuVTJGbXRpQVhwS1AwR0V6amk3TEFIRG5UamczMy8y?=
 =?iso-2022-jp?B?b1NEanh3Yko1Umxzb2V6WTF2NENWVmtMMFcvdzd1VlN3YTl2TVFHNmtn?=
 =?iso-2022-jp?B?YXNyOVI2NVRxQVRjU0FlYWhNdHQzRmwrNGtuL0pFWUtpbVduRHlnTnV4?=
 =?iso-2022-jp?B?cGFGUmUvdksxUWwzTUtPREMyMlYxTWJ1YXg2Uy83U3VlZWVkRzBhK0V3?=
 =?iso-2022-jp?B?R2tOSHZTeG9SL2cza1dIQkRrY3p2U2xwS2g1S2VubXoreDJZMm0xU1pr?=
 =?iso-2022-jp?B?TmY3YlpCWGJQVGZCQmJiQ1B3RjlDd2ZFdUJlSVB2Sks2SUlNcXRWTW1Q?=
 =?iso-2022-jp?B?RlhPOGdPUkM1S1BFZERINU9uSGNrNlpDSjdGVDB2WjNDT3J3SWRpa0d6?=
 =?iso-2022-jp?B?QVNSNUc5RnBTZEIvcmZoZmoxa1dlalpXN3RmMWRkZnhtNEZ3ZGNhTlJ1?=
 =?iso-2022-jp?B?OFZoOUpEMUFSNlU5L3NZRGpudFJpMzR2cnlGREplNG9JOHpqdityYnZC?=
 =?iso-2022-jp?B?d2QyRDhvNXkwUHdXWE5nOGk5THV1cWw5ZExBT29qZWw5NjRzcDNhQXY2?=
 =?iso-2022-jp?B?RXZlN0dnYnpod1phdTF1Sng5WUM4cjJnMkU4aHlncUZiWEV2VHRxZmJX?=
 =?iso-2022-jp?B?U0FpN3RjQ0E2UlFIN3c5UmFVenVqcFZtRHJtWUhkSGtsclB2dmprdlRZ?=
 =?iso-2022-jp?B?a09rNC9ZZ0hmUXkwc09KZlBwMnFJTGhIcTZ6M3drWHAyL2g5MHlwYkdP?=
 =?iso-2022-jp?B?cnBZeHlSM1ltV1NWamRLdm80UjVScEJiUnhFbjFjVWxpOTM0SG5QTnVj?=
 =?iso-2022-jp?B?YThwME83d21GUlE0YUF3QjY1aUk4UVNqRjJtK3FsQWhQcExhdVI1VEE3?=
 =?iso-2022-jp?B?alpCMmpncm1TMXJLY0dXb1QvTG5KZ2EyeGlnc0pBMnB6d0Z6Vy9nTVFi?=
 =?iso-2022-jp?B?SjNZbDNvaXAvOHFSMnhRMTBrSU9qOVJlRzIyQUFOaytrQ3ZIN2ZYNHZF?=
 =?iso-2022-jp?B?ckJSc1grUzUvQU4zTk84MmdhbmFpUTVQNkZDb1Z0cWlXaFRlSEc2S3ZL?=
 =?iso-2022-jp?B?SklhQkRJY0pPMVdGQUE5Q2tOUi91aEpWWG0yOThMaFMxM2M2WEhCMzNn?=
 =?iso-2022-jp?B?dE9PZmtHMDJzeFFCajAwNm9VRjNKbGFsbUExUmNBNmhBT3B2R2ErRWZI?=
 =?iso-2022-jp?B?cnIxMzdQQWY0SExRQXcyb01HNGt1bXgzcThXZktPN25EbjBZVFFKRFFx?=
 =?iso-2022-jp?B?SFFrbjJnekcrb0hXaElOUGhmd3dBcTAzRUhuSkRGMm9BTHBsRTVnVytj?=
 =?iso-2022-jp?B?Ri95MXh6cXNnbU5UTUZsbEI2SnJlWERsaTJQVEd0QTJOMG5Xd25Nbm81?=
 =?iso-2022-jp?B?WkhGYWZRSXN6TzNBMnYyTFB4Z0poR2pJMnRaWjhlVXNGQWorK29lZTZu?=
 =?iso-2022-jp?B?YlZ0Umk4TFo1TGIrK1RRWjIzdVdFYWx3Wjk1RkgzMitrQ1JDdEVxSVJC?=
 =?iso-2022-jp?B?bnRkbldNLzRmVHNJY0xCQ0tvR0J5V3EzWWszU3BBdnRKanAvS0psYWJT?=
 =?iso-2022-jp?B?emdMakxpWnlKUjA4T1hsZ1c0d0lTT0JWTDBhczl6TlBpWTFXZ2ZmYjJl?=
 =?iso-2022-jp?B?RVg2QWNNZXZaYVNQUjliNklUNzFKTHdwNTZ3TERvSEdvL1FndFJEK2ZM?=
 =?iso-2022-jp?B?QmRCbFI4YXNScUpvZUJXaWZiWnVCNTk1VytRaUZUVjJoemZBWklQY0E4?=
 =?iso-2022-jp?B?aktMbm16VnhNTC9zcnZqdnZ2Z0xyWGtiQ1JHMG13bDRPN0pYNFdzb3Qz?=
 =?iso-2022-jp?B?bTUzN2pmSXNmRVBaVDZxN0NaOUV2S0xpaldmZ0xRazhwb3NhTStWSkd5?=
 =?iso-2022-jp?B?SHFnSTJoZjBuSU9PN3JQZmJOMElvZGpFOFIya2RnLzJsdnI2VDhNUkFt?=
 =?iso-2022-jp?B?Tkp5ZFluT3VQK2dYd2JoVmMvNWE5VmJ6clBkKy9TZDdEZzhjNldaZndU?=
 =?iso-2022-jp?B?aHR3ZkV4K1BOQWtIQmpOOVBLeG1WaEtVa0RxQWI0NmtHT1crNE1yb0RH?=
 =?iso-2022-jp?B?bG82OUVhZjNubGlScmNQOEprUDdjVlU1U1kwNWNhV1YrSzRKVGdZbDBy?=
 =?iso-2022-jp?B?d2tZc1k9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a12245-cb65-470a-81ce-08ddb9d14a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 01:31:10.1683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ty8PwDN0V45skPcreo2Y912AZMfppf+vBGibUit2orCEsobhefZ6QgB6TU4FaXiQvMULXQT8wyMRTUMpCh1z8p5O1uYzR3U5MeajV8Jvo3Wxt7vbXo1yE9ciZ/ctxisW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8340
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Jul 2025 01:31:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19319

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Wednesday, July 2, 2025 7:37 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.12.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
>=20
> Dear All,
>=20
> This patch series adds support for the Mali-G52 GPU on the RZ/G3E SoC int=
o
> linux-cip 6.12.y Linux Kernel.
>=20
> The changes include updating the device tree bindings, adding the GPU nod=
e
> to the SoC device tree, and enabling the GPU on the R9A09G047E57 SMARC
> SoM board.
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (2):
>   clk: renesas: r9a09g047: Add ICU clock/reset
>   clk: renesas: r9a09g047: Add CANFD clocks and resets
>=20
> Fabrizio Castro (1):
>   clk: renesas: r9a09g057: Add entries for the DMACs
>=20
> John Madieu (1):
>   clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP
>=20
> Lad Prabhakar (3):
>   clk: renesas: rzv2h: Refactor PLL configuration handling
>   clk: renesas: r9a09g057: Add clock and reset entries for GE3D
>   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC
>=20
> Tommaso Merciai (5):
>   clk: renesas: r9a09g047: Add CRU0 clocks and resets
>   clk: renesas: r9a09g047: Add clock and reset entries for GE3D
>   dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
>   arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
>   arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52
>=20
>  .../bindings/gpu/arm,mali-bifrost.yaml        |  4 ++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 49
> +++++++++++++++++
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 15 ++++++
>  drivers/clk/renesas/r9a09g047-cpg.c           | 53
> ++++++++++++++++++-
>  drivers/clk/renesas/r9a09g057-cpg.c           | 40 +++++++++++++-
>  drivers/clk/renesas/rzv2h-cpg.c               | 13 +++--
>  drivers/clk/renesas/rzv2h-cpg.h               | 34 +++++++++---
>  7 files changed, 193 insertions(+), 15 deletions(-)
>=20


I reviewed this series, looks good to me.
I can apply, if there are no other comments and test is green.
  Test: https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/190=
3593313

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro



