Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ED3CE7A8B
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 08:35:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13468.1763109336066469493
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 00:35:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=VEgWuMZi;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.135, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1763109312;x=1764318912;bh=
	+Ba1LyCoXH3h4nh3Km3zYk2CvP63SqePQ/oUCvEyfTY=;b=VEgWuMZiRbViAl5dMz8XHZ7AlQKAk0
	ky9JZk7iiFZDjGwNQ0MPSg+blLWua5uDtzVWqQmwaLnVm3gdwsO14gq4+ZZf/Z7ejmg4F9gHZVM50
	E5pniG3pnrXlFMz1PbN3XAyGaPgyA/Jl6fdyLHML2CN9S2m+2r2KZQPMhT6Z79w6HktSbD2n2xyUP
	OF2Hpw4ryCoixSildGk7E8J1oZq2HYOPsrjYcRXkWE1Iculodt3tmXJ6wBrWVRUQzqZtSybVQ+sXB
	CtCS4dVmejFrIRcfM7hJbcbB0JCiizx7Z6wvxErlPuX1YKTP/KzZuJZPlSBMhc2YMp3Px7nyL16x2
	DSKQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 5AE8ZB1X859952; Fri, 14 Nov 2025 17:35:12 +0900
X-Iguazu-Qid: 2yAaYMbrhVNr1QGqUq
X-Iguazu-QSIG: v=2; s=0; t=1763109311; q=2yAaYMbrhVNr1QGqUq; m=ZXWBmzb4h2XS0Lwyv9NiWC+9V61e0rY2eKKX3q+gSLU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d79SH14rZz1xnZ; Fri, 14 Nov 2025 17:35:11 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWKG7i8ZP5DlJFD5IqiZ/PR1YCkXwIJBA28naZMkoNodySBXCjpHNJrzGqPUBUnBGhCb2bWblLD/YmdlC5NAC2wFF2ChKHXRlnKZRxlaOzEtwJbWaMQ5Xx1m7tZmLXsvnQSQ7hvHMhvwebmOjkZx11S9h0ZmVFQOD8KBHW3j6sKnrnFxlflSmkbuMlNDE0hgpwB9A+HH0dacJ3X90yVjsiU6uEzw2duvsiRlQZd876o9WH9rMnKKNZNFVBnUYFpFCNajG1Ew516Oq9sJBPVVk5l2UpZ8tMIzErJss/smNffcP4WZ16r/shwu8TWg3LcLVz+eJbCdinKPgn1HKi4mYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Q3NA5986UvMF0esDaqfegJjI7Zr5+Hc+Y/Lzosi0E0=;
 b=BjwRHrOvZ3e8dQxiOLWXrKaJ8FjYNQomOC6+OqEdlFqRNkTZ0KML9L+1/zTMH0iVNqBH8zWpWnZhjZLrOCzrquPxPx8ZNFPEObPD7L9Q5PhRnTPFNT5qwdEgHOtp5rEJwVewBNkoaQiXS+ftYIW2SDNE+QHNbW4us5UrUT1/C8wwvKEcYupQSc6t65M9Jrf8n9X5IUh0RxphZMN8tJpfRTMVkP47xOf3VCmtqR7GeE9qVVWsfrhi04Pp8/s8RE9K3U9pwIUUiBzBvvaRDqFDhSQsGvLDGiL5429rdX6h4ogcV4EuyaMVDb8GtGMRXWz+cBiBHCfIdWH8CuMPFjwFKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>,
        <masami.ichikawa@cybertrust.co.jp>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>, <ovidiu.panait.rb@renesas.com>
Subject: [ANNOUNCE] Release v6.12.57-cip13
Thread-Topic: [ANNOUNCE] Release v6.12.57-cip13
Thread-Index: AdxVQUjegVSi3zjcRjeVicDbPfRklg==
Date: Fri, 14 Nov 2025 08:35:07 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E0511AD31E1991E1F7D0CDCAA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYCPR01MB10590:EE_
x-ms-office365-filtering-correlation-id: 1da05042-9539-43a4-01bb-08de2358b76d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?R3FCMkVyMEdzY2Jhb2NJYW9TVWRHZmQ0QXBmK2NFekQxK212bDhPbWVI?=
 =?iso-2022-jp?B?dnJ0VXJqM2cwdFBydlZZTy9YbTBXcElXM0lBQ3dsZVozRUJwRnBjbzIw?=
 =?iso-2022-jp?B?L1A4cVdwZERDbmhtbG5JYzZOZ3ZKNVFCb3JPR0s2RTRLRHN6MkNsNWVL?=
 =?iso-2022-jp?B?RXo4WDM3LzBEczJKRXpmcG1JWVBDbnVUUU4ya1lyS3lhL1VWRHJ4eXQr?=
 =?iso-2022-jp?B?UVNaU0VBNzB1NUszRDZGbFM1ZWt5dTdGVThEYUkwUDlpTHdaL2NUSUEz?=
 =?iso-2022-jp?B?R3F2ckFabDZFRm5wRDZFNUM5Z3BLb0FXelBPWkJsMm5taXdqdUQyZkRS?=
 =?iso-2022-jp?B?RG40MDVDUTdHbk5VbVhoc0IrVkFIZStDczc1QlBISk81azV5ZkZoektI?=
 =?iso-2022-jp?B?cnltdS84cDZoYXFRSzExbm8zNXduUWpnemVGZWtWYUJlMnNsMUVsWG5a?=
 =?iso-2022-jp?B?MVpvQmhQd3FSZGFoQ1FFMzArQ2VhM1dNMTBOMUVmU2hXbzJXTTVIV3pv?=
 =?iso-2022-jp?B?ejFLQkQxVzJNb0VDVHhlR2FvL21IMEhYUWFzL3JvcTB6cnRMcmEvVTh0?=
 =?iso-2022-jp?B?NEY0UVVGRkYvOXNKMDhDalpYbkZWTTFiUDR6am1vdzlUNk5wY3NJNldh?=
 =?iso-2022-jp?B?a0lNL1ZKUndsV0E1ZjQ1NkRmT2xvUDZMWndpQk9VN2JHNUc1d3IvU2Jl?=
 =?iso-2022-jp?B?Tk9ZaVhpWERJVkFubnBUVEpobjEyRVMrcGFOK2NUUWNBTGowQVl4WEIv?=
 =?iso-2022-jp?B?ZGs0cjlQd3Q2Y3JVbU5ST3krYVgxL3Nsc3pxZ21TMjVTSXNCeGdpdmtC?=
 =?iso-2022-jp?B?WldjWkE5UkFrWENaZkdmb3VtcHdBaEFIOU5oYWtJMjh0b3IrNDRRamI1?=
 =?iso-2022-jp?B?M1VaalVJcnJlRHFhNzMxb1RlS3RqL1B2ZjlnalpjaGNONWNUWGVnRVFH?=
 =?iso-2022-jp?B?Y0daK21YWWo0WUNtb2ZBbjJ5YXNOd2w1VGxCK3dOdVpxUTV2U3JPZFVx?=
 =?iso-2022-jp?B?SGEzSFlEajVWT3UzNDU0KzhwRWZ2S0ZyNnE1Q1pSZERucjhtWGVyVFh1?=
 =?iso-2022-jp?B?UldCVC94SHZxcFJOVHlQd1l2NTFXVHVpUThzQmNWRTZ0QWpkYW9WNWlS?=
 =?iso-2022-jp?B?YkRHZ3o4eU5HZlRodVBtN1BiY0pJRWRGdmZwRSsxVWNhTU5lU0ZBanpX?=
 =?iso-2022-jp?B?NVNVR1FEbU14ODVQL2JNanpiMWwvQWdOQ2Qzc1hwWk5QV2NndEh3TUdp?=
 =?iso-2022-jp?B?TVI2ZXo4azlYUStFVUl2c1VnN3FteTQzOXhQZDFWVjZFbXBPL094QUxz?=
 =?iso-2022-jp?B?ZTY3MnNSTGs1Y0pFQTR5eksvMTBDZ3l4ZFpWR2sremRpb1JDNkdad09E?=
 =?iso-2022-jp?B?eE5RajBIcjk5THZpSHlySzhMRGNjMWJmOGwyRFY0NmU2Nmh3Tis4L29a?=
 =?iso-2022-jp?B?MlRFc1daRnRZWkE5N3BKMStPYks4ZnVkSzlLWXdqMyttb1NaVkRUYjBU?=
 =?iso-2022-jp?B?ZndDbEVmelFKYmMzQm5URkJZNmRuZk9YbjZPSG9uclZXRHZwVjkxb29F?=
 =?iso-2022-jp?B?d0JiT2NDQzNFMnBWREdpTTNOcStLNTNnazBLclpsWFM4L0xaMVJ5bHFQ?=
 =?iso-2022-jp?B?eTMyTERIaWFNY29RWDNLTDZrcUU0dmFTbkZMcWFZMGFxYURtMVg1YmZt?=
 =?iso-2022-jp?B?bGtiTHFVTGdkalVsSEd0NkRaSzdTOGhVV2h6SldlNDdtWThYdUQveHEw?=
 =?iso-2022-jp?B?Y0FnS2tKbWUwTktzUDFOVGNHckVRbEdtODMvK3hUVUR5SWwvTDgwTVJV?=
 =?iso-2022-jp?B?SDljaU9zamc1Ym1wS25ZWCtyWDdCamdJUWRseGRCQ0xTd1MwZjg0M2Mw?=
 =?iso-2022-jp?B?WDkzT1lYbFB3NGRDa2pVTEFJR1YrYlMrbHY1N3U1eElBTlY3Z2hUM3lF?=
 =?iso-2022-jp?B?UWc0Z2lHL3QyK3VBWmJpeURkbVl0LzNGWVZicnRJajZxRWk0SStXcGhJ?=
 =?iso-2022-jp?B?LzFRTDJ2eWd0MC9TYmNJT1l6MUxUejNpaUVlTHJkOExVVjErVEJEWjB2?=
 =?iso-2022-jp?B?K2lMMkV3ek53K3hoVHpHR2dNSThUVlE3M1BYQ3YyRFp1b29WazZ4VnNE?=
 =?iso-2022-jp?B?Yjc4KzZYcUlGSFpPNW1Ic2JTMy9yYzVjRkNaSno5ZjlyVEgxcWFnODl1?=
 =?iso-2022-jp?B?LzFNUXNKdjN1aWlNOGU1ckpNdjNmdmhj?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YkVXdTFITGJFd3I5NEVrMFhTaUFncG53OVFTcXJwMHhSQTlLc2U0cW4y?=
 =?iso-2022-jp?B?UEgyNDhGRWRUUHRVeXdnbmdvQll5MjBqV3EwUkROVjd6WVhXUEdPNzl0?=
 =?iso-2022-jp?B?Q3doaUR6SE9WNVhqQUVIOFJmS3lFNy9qL29naTJxSTE2S3k4dkdvZ1NL?=
 =?iso-2022-jp?B?TWNiRXlrQzliWEQ2UHZ6cDVsZnFzUitBL3ViQzg3YWJmclNpc2UvZU5k?=
 =?iso-2022-jp?B?RStXb0hjY0tRL0xibkFwM2piZWNIUXJud0hYMWEvWm1jNGhldThHQmZs?=
 =?iso-2022-jp?B?R0RnRmNnMFJNd2NtMDBHVWZVaDBmYVRmb2dSa3ZDZExFT0MvampQRTV0?=
 =?iso-2022-jp?B?YnBUMFh2dEtOc3hnaHhTOFpYL25HL0FjbHlsVHAwcWlWcHdGQnE4NG4x?=
 =?iso-2022-jp?B?RlVsVjBVREMyYytqbElQTEp2TERIV1JKSEpCeDhmM1F4S24zRlphS1Aw?=
 =?iso-2022-jp?B?dE5tYi9qVjNINkNzY2tHbDlEcTd1TU9DQ2VFQ1Q0bVI2WHhXcExpczZB?=
 =?iso-2022-jp?B?RWJFbDZQajhUVmJIM3BGUFhVaXR6ejBoSDBvQTdzMnhVOW5jVHAxczVh?=
 =?iso-2022-jp?B?VEE3eUJoV3cwTzY5MFdyZTdEbmFHdkI5WnE3di85VFZDTVYweS9jMitq?=
 =?iso-2022-jp?B?WXJuSFBKcENhRkJGWCtCdWtiMGFVRzJJZ0ovT1BNc2hmdDBWUTBYSGtx?=
 =?iso-2022-jp?B?S0IvVlNVSTA3a0tUcXhwK2FuTitadEtZbkNseWRCemY4MlR3VW5TMW1G?=
 =?iso-2022-jp?B?dGZ2RVI4bEdZTHRNa05nN1QvQ0x0RlZlMjAwT3dvZE8wL2d2UEtpM1J3?=
 =?iso-2022-jp?B?WitiNmViOVg4cjlydVI2NVNuTGtxNzFFT29ocTk4UUVMb3l0NTRsSS9X?=
 =?iso-2022-jp?B?eCszenZpUGZ2SFFyb05Jb0xTRXA5TlZEU2tjZ3crOU9xZHRlZVkrdFZR?=
 =?iso-2022-jp?B?dThKYVVsRHluZE1LS1RpUVd2ZTFYd1pFVzJoN1I1SEpMWFJqOThyLzNu?=
 =?iso-2022-jp?B?T0kvdlhsaWVDNDczNmRlWkdHQ2pOSWlzM2lRT1BPVERmRUl5Q1J3czN4?=
 =?iso-2022-jp?B?ckhmU1g0ZEt1RVVSRmNZT2RLVGtiTzhKelhnVFlGb1BubmlzbldsNFBQ?=
 =?iso-2022-jp?B?TjhpcURqMmVRWS91cVZ6Q1E0WWlYUjkwT0cyaDc0UE1STXV4L3UwVGk5?=
 =?iso-2022-jp?B?SFhzbFR4T0drU0dMakZJbW5yUlczK25WdG9mZDNiQkpwd09FM1pYaXpF?=
 =?iso-2022-jp?B?WFRObm9rb0xiSVJhQWRBVzQ2ZGhRdmJEWnFuK21yVG5UcmpERXdCZ3F0?=
 =?iso-2022-jp?B?djdLbW0zdFUxZm9ZL2czMS9WYkpZKzd0N3pseDZyWmthczEvcVVZTTNU?=
 =?iso-2022-jp?B?TURJUlFuMFNrcjZkd0lnbGsyNFZWWDl6WEhzbzhud1l0c3drOFZOZ1ds?=
 =?iso-2022-jp?B?K3FaaGFiU2hhN09QNE0xUGJXdDRBOWh6L1RQeFVpajV4VEszdk40UytV?=
 =?iso-2022-jp?B?a0ZyWVFMRHJHemlzRWorL3BvaUhGc29TRmd6OHV0dzdKMlRjdUZhc3Bp?=
 =?iso-2022-jp?B?MHBPc21QK2I4UE9rUy9YTmthQ3ZtQ2kwS3ZrV1Zscm5zblgxMXlGYXlY?=
 =?iso-2022-jp?B?a2ljNUhUa25NdDNYUVRhcFM5QnNQbm9GcDZheGphMHBjaitCQWs0VG9K?=
 =?iso-2022-jp?B?YUJUZjhDKzNkSnltalRhUkZ2U3YxeEFNQ3BreXF0ZEZvcVAvT3hOSHFz?=
 =?iso-2022-jp?B?bzVVbVZxUjVhZzV3YUhXWUQ3cGNtTDNVU25MMjJpOFVqbWNjOFM3RVUy?=
 =?iso-2022-jp?B?eDA3REFQZVhkS1lvbWJxT09VQlN2M1ZyaVM3NFdYbnFNZ3MyZHROOG1s?=
 =?iso-2022-jp?B?V2RVallXR2FRcUVKeGF4Wi9McDN6OGFyU2YyTkU1OUNIU1hxdTcyRG5V?=
 =?iso-2022-jp?B?bTNZTEoyMjUxalZvanFyM3Y4NU95U1dkK0M4YmpHcTk5c2dGSUVyZjBk?=
 =?iso-2022-jp?B?VzljOUEwY0Q4c0E5aFRqaWg3WEJVd1BYUGluaVJ0ZmpoRUVFVGgxQTFm?=
 =?iso-2022-jp?B?QmhMRFZJTmFreC91a3Z0bkg2RytZdzFORnczNDg3cGZ1UnBIcTdwRGE2?=
 =?iso-2022-jp?B?akRTWjJKa2cwYzVCNFJrS2hBUEd0K1pIdW9uZjQ3djd2SGo3UWlpa1RY?=
 =?iso-2022-jp?B?SldpT0xkcWthS2xpUW5LV25CbUxFOTJOUzF4clRySWJoeVlmWlo0R0pI?=
 =?iso-2022-jp?B?K2RvelpNZDc5ekZ3WWNEZXo0eXo5OWQ4TTdpaFdYOHVQZllMZVYzdmlG?=
 =?iso-2022-jp?B?NW5CQnNyWkhlNEIrWHRCWGkvU2FvQkhVR2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da05042-9539-43a4-01bb-08de2358b76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 08:35:07.4318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jc0bgMJVuok66cTG2wjZ/W35kI1iIqVY14zc5Y+7fj7BwJimXuSDliICbs+bXOJCW4hmSqwcKimk0SG3YIFCmGlzEBwmHh63UCzHrwP9e6hFA0/lXNLER1MONo6cyiCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10590
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 08:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20536

Hi all,

CIP kernel team has released Linux kernel v6.12.57-cip13.

This release includes the dts patch for the Renesas ARM64 SoC that was miss=
ing.
The base LTS kernel version unchanged at 6.12.57.

Information about this release is as follows:

  v6.12.57-cip13:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      b3b7da3e4cc2c45898146ce9f79147f0ae820e4c
    fixed CVEs:
      None
    added commits:
      CIP: Bump version suffix to -cip13 after updates with latest cip
      arm64: dts: renesas: r9a09g057: Add ICU node

Best regards,
  Nobuhiro


