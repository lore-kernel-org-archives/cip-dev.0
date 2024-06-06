Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A17C27C54
	for <webhook@archiver.kernel.org>; Thu,  6 Jun 2024 14:19:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.15677.1717683588263764193
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jun 2024 07:19:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=eS5oSLii;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1717683565;x=1718893165;bh=7f
	mfBQzywDBcBJD7cL577fJ98EM4nnZAZOKeYG29LOE=;b=eS5oSLiinA5aUZuB0xjDcRC4kLN549xv
	Fq7A+Jel6H4+PMFCsXRjKEXfRo0FrTT7ysIoYQF4+UyZPEi0BVO+PdWSkLV3atWZNUXJsrU0aN3I1
	jJvWw5iq2b/wfY5oFciY+jIbqB61ukfYNcYztfFVuWeRV0979Wl/CoGmpG+9AsHyXl1aj0HcUPJ3T
	Zg5TPmDjxhwbxoLvLJLYYO7BTx4sMur6/TpQgLEs0bcCCnLjtiUHZBgJg3mOH6EKUKOf2/jHdI1J8
	s1j2VEuwk1MJERenH8jBVp/qX1SPpS7RVqaSsJueTGTogftVObqBuzUEKg2JGORE3NOq7BgYojWWL
	ag==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 456EJOSf1058598; Thu, 6 Jun 2024 23:19:24 +0900
X-Iguazu-Qid: 2rWhAUbYjzhZVNSFFo
X-Iguazu-QSIG: v=2; s=0; t=1717683563; q=2rWhAUbYjzhZVNSFFo; m=A5J7mFOCIUSisT7wnSAS4YpWFFMD+CSMIoTDYuWxYQE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 456EJK8R909994
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 23:19:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UlTWTdWhvFHa9lbwAWy2NQHIMM73vJzDQMeZ4AQfLvgaYbya7swdrfv3Dxcp4ul+b3rh9lCG04eQHF9ppYz5ZBwG3DAhDCcdhg8ua5brdbrjfraxMpx4lJOtKpF/7K7L3biSN8ySgqXIeqrxTI5+if9HVzcherzBERp5evj/r5cGj8zH9LIrQoc0coBElL7JWn0orRXeBWHKJs7N+jvMkkQFW3ScKQ0P0kLk8QTli/iHp9i4aolWt+gZbE5o9Vp3iOoB+4vAeK2EnfGSvO6v95z6NRfOHqQukIVXaFU/HgeQWBiO8uOqE4sILEWcxUm2jOAMEUjZh/GhceYOcDKB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOdrXHhR+SUISeJOSVOOFD0IARx70i/+ldOL9c4euyk=;
 b=j9ClWr2VjTZsrXqMuj8C0mZdzKg3sPMrf9bWMnTzCg2zoqascWHFTrGqssj2dT9qceV4NOdBNR5Fs1jA671Z2RQgaZrLBj2G9/5cHZA4p0GoVsuB/OAZDwfIdj11VAMPrbqxfMkociNc9pksVO47ZQTGOe4MA4LUfsgufrG7ZYHwbTm3+AsySkCNYmdqV6pdOuJt95gOmvSZzqNkPQglkVygSMGCBYyG/DRgjc0SPWAHpHsI2ZI2Vo6p9NzWlLGjnNY6K8eBVGBuLCoP9DjlKfEFH9DNxelLdc0rnbK2JeooHA1YGmWlmjdf0UzznxsTSibNgDL1EW6Talowpdadeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <uli@fpond.eu>, <pavel@denx.de>
Subject: [ANNOUNCE] Release v4.19.315-cip110
Thread-Topic: [ANNOUNCE] Release v4.19.315-cip110
Thread-Index: Adq4HGm1SYRevpK5RoGTo2nGfoZsrg==
Date: Thu, 6 Jun 2024 14:19:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6391788A43AD00C6BF6EADF292FA2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|TYBPR01MB5309:EE_
x-ms-office365-filtering-correlation-id: 0dff3c2e-3e47-4e9e-5474-08dc8633a6fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|366007|376005|1800799015|38070700009|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?V3FrMndKYllndXBXQnF6d3pWVThOR3Q3d1BnMkM5UVFRUmo3Z2lLc1A3?=
 =?iso-2022-jp?B?UlI2NnRJb2lzTzdBNk1mYjh3Q3UydHc0MDBWZG10M2djOG5Zd0J3NjNB?=
 =?iso-2022-jp?B?T2F6cHgxQ1BrK2Z2TFE3VmQ4N2VpSGNSZDM4UzF3VXJWK0FRYlZTbXA4?=
 =?iso-2022-jp?B?UUhBK3FQaURNMlljQmg1R3VBTzE0ZlA5c1VxaEN1N1VpYURRbk1CTCtE?=
 =?iso-2022-jp?B?Skg1MlArSlBJNmlQVTMvYjZrTzBLN1VUM0wwK1dFMkFiQitxNDdVQnd1?=
 =?iso-2022-jp?B?dFRucE84b2Y4K2FYNzNVc0VTWlVEQ256cTZ2blNLMlMzZ2VBSlRYS1Fm?=
 =?iso-2022-jp?B?eWlxTE85UEV2YStTVHIySjQvSHFmRVBXcUR6aFpZWHJDdUF5YWRLMTVs?=
 =?iso-2022-jp?B?ZXpKcUJYeURBWW9HV0Mzb0lTaXBROVlqTkllWkVZT2N0dmVIdXFOSjRK?=
 =?iso-2022-jp?B?Ly9IMVFaV2xKbW5ydkJCRU91dDdtZUh2aGM2TDc1UDl3Sk5NeWd3dnJK?=
 =?iso-2022-jp?B?emZha1BIRUNCNEJ2TVZBRyswQlRJYU1laWtGRks4UW5ZT0VUOFMrZVhX?=
 =?iso-2022-jp?B?R0Z1Yk40UVFRL3UwVkp1SXdDTktoYlhMblp3dXpyeFBYOWRoU01KWmlZ?=
 =?iso-2022-jp?B?Skw2OWgrSkhhOHhmTW5wWUxrSTRLZjhNZVkxR25ldWhXZTE0L2twNzhL?=
 =?iso-2022-jp?B?Y0Q5R2hoSzc1TjdaUUl3MjI1ZWJwY2d2aFR5MndXNGdMOTZjK3NYb29O?=
 =?iso-2022-jp?B?Vm50b1ZvWGcwdituU2wwL3U3UDlPZWhheEhQVlAvd3NkeFRaUERnZGdk?=
 =?iso-2022-jp?B?WVMzVklsbG5OMGZHQnVzQ2lTQTVaRFNTNkZoM1FJSk9oYlkwd1BQRnYv?=
 =?iso-2022-jp?B?eEczODJlclRJa2lJU0lvT0xwOFNEcWpXLzM1TTJBS1liQS9RVzNMU3Y0?=
 =?iso-2022-jp?B?YnFPQ3N1TndKR3Q1VldxNnc5aVRUU0RFclJZVU5yeGgva3BPYmtjUmxo?=
 =?iso-2022-jp?B?NEVJL0Rjc1NZWmFWRS9DYnZzVWRoSzh6cytjWDhTSXJYVnpvNnpsa3M4?=
 =?iso-2022-jp?B?bkhRb3BOWDR3WFQ5ckZZU3F2SWZlejYxWHliZnhJRVZuT3pmS0RSS3JB?=
 =?iso-2022-jp?B?ZFhrNkl2NWNLUENmVmJndXM0ZnZzTFBNVzJHTXlVcThndTFSd1NIRjEx?=
 =?iso-2022-jp?B?MFc1eUVEUnViZkxEWFpNVTJzdEtTemszOGEyRStEYVIvSVNWcy9McWgw?=
 =?iso-2022-jp?B?WERtdS9IM1JZeHVZaGJ0LzVkTTZqVmF6MERQdUcyeWYwUm45ZitxZ2p4?=
 =?iso-2022-jp?B?eTQ4MTQyeUp3bUZDMWpyRlluMGdJTjFpNTc0c05lUDRUMDVwQk9HNldx?=
 =?iso-2022-jp?B?emU1SW1TWCs0SjVSSkZENmNhNHFHSktGRDZXNGRVcXFSNjVxZkFnc2VU?=
 =?iso-2022-jp?B?QzVkbUNsZUM5R1I5d3BCZnptQmZXRytQbVJaVTlyN29ub21sNHlKeXhW?=
 =?iso-2022-jp?B?VU9yKzd1Ylg2Q2twSVhnR1IxYkhIMlFabXFHdzdyWUQxTlZMcWUyUjd5?=
 =?iso-2022-jp?B?bWVpdkdwSWdTakd3WTc3L21sKzlRck1jK1hVbXpUcm9FTE1yejZ2ZkpY?=
 =?iso-2022-jp?B?OFo4WE16OE9ZZVF6ZTdLQXI0dzN0MkZUYStFTFVlcmpoS1phNW9LcktI?=
 =?iso-2022-jp?B?ZmlnWDF2VHl6QkVadkFtOVlpdzBnZ0ZBUnBjNjcvTk5BWk9TWEc2WGNU?=
 =?iso-2022-jp?B?Y2ZUeHJKV3J0VHVRSlZpVk1EamFMR0ZHQWpwckdPNTVCUEhZUzFVVGpq?=
 =?iso-2022-jp?B?Q2hxVGN1UERudWczRXhyU1hEK2RwNHl1dlpndlQvQ3BaY1lUYW9zeGNp?=
 =?iso-2022-jp?B?ZDBGV05wS3ZYTnFzWTRDU20xUGpFRzVLVjQxSEhVSmNkcTNjMGFhTndQ?=
 =?iso-2022-jp?B?Ykp5SGl6NnF2WE9aeXVORytIaC8waytzSVlZTS93YkwraEkvbTJ1UlFV?=
 =?iso-2022-jp?B?QWs5akJsMFNwZXUxcE9kNTYzcWRkajdXZHQ5b0pjMWFmcDREYXM2cXV0?=
 =?iso-2022-jp?B?UGc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Vm05eU1WeXlpOHJYak1UcC80eldoZTJ5L2MxdERHOE1HZGpFSG0zaVov?=
 =?iso-2022-jp?B?cmM5ZWNuZXhvWjFFc1pwTVhLcmVKdUVCbzFTTWFFRkp2MmE5c0djVFR5?=
 =?iso-2022-jp?B?SUNZbDBCZ1ZMdlMrYzlUOVIvQ2VXYzJtNWtOd25oVzM5bHRZTzBWZjhX?=
 =?iso-2022-jp?B?ZTZVdXB3Tk4vSmRvdE44OUFyMkZFRW9nZkpQY3FTd3BZNnJBOXZUVy9x?=
 =?iso-2022-jp?B?cTZ1YzFTYWhodGdLSlF6cm1LT3lhZTBET0tQT09FVmlkcy8yZXpMZlY3?=
 =?iso-2022-jp?B?MUZLSi9tSmRXeURyQUsyRm5CVkhtQnljdHVwS2dIQmtVTWVSMStoMnVI?=
 =?iso-2022-jp?B?ejFQZkQzZmVJeHlycVBDZGNUaTR3NGZ2RitIZzN2dG9zK0VSZzFqajZo?=
 =?iso-2022-jp?B?eUtvRERGekFQdmJ6Y0ZEemI1dlY5ZURLWEo1UGJaV3ViZnF6THJHVFlN?=
 =?iso-2022-jp?B?THd3UHg4UzdUM3dFbW9odXNCSjcrQmVRVHovVlRIR2svYllnemVVaDlj?=
 =?iso-2022-jp?B?VVNvK0hBWVBNVCt0cE1WR2grZEdUVzdKRmdKczZkaWNHcnFVekNSNFNw?=
 =?iso-2022-jp?B?bTI2aTIwOTNYeTlKa2FYQkF5RmdIWlRLdENGbTYzWUxESy9NVUUyZXd4?=
 =?iso-2022-jp?B?eGZDR3hYbVNvYVpuem5KZjZVdTEyNWprVlhtT2JZd01KbDIvSWtUZlNy?=
 =?iso-2022-jp?B?SDJVQ1dsY0hUdUFKOE5hMGU4ZVQwTG96dHR3MCtpdmFsSEtobW5aR0JK?=
 =?iso-2022-jp?B?K0VXTG05ZjBMTXlRQVUyeElFT3RxaXdSYlJQcyt1K05lbEV2TG8xekl6?=
 =?iso-2022-jp?B?NVlzY2JwU0o0aFpVOVBkV1AxR0RLam1MNlh5UTZ3Q3psaFdkMUpFMHlH?=
 =?iso-2022-jp?B?eU94a3BML08waU9DUXQxMmprRkd0QXJqampuNU02VUZWUnhCN08zOTVp?=
 =?iso-2022-jp?B?SHovLzM3dlFQaGVUazRZUzFKZlJsZm9NUVU3NGpXSktGeERRL3BOUmNq?=
 =?iso-2022-jp?B?dEt5WXRNc2Q1amwzWHhOOGtLTUk5N3M5aE00ZHRkODNJd1pEaWNyalhD?=
 =?iso-2022-jp?B?VEpobWFPaE5RZER3UzNnMHBzMGRFSXB0RFk5VFluL2RRT1lUR0pnai9G?=
 =?iso-2022-jp?B?RWJJMmk4ZWJwLys1dzdQZG0vRW5OUkwydkZiRldkTUhnTzVWRTBHOXZt?=
 =?iso-2022-jp?B?bno5WVVmYzVMWHRZZlhjOUpsNEVVL1ZneGhHUmx1L1ArTDUzTGoxdjBs?=
 =?iso-2022-jp?B?K1lFUFNmZW1CcmROcWJQem1nRnpyY0wzTDYvNGJhb0xMdEtTR0hXcXhq?=
 =?iso-2022-jp?B?UW1JTyt6Q1RJcnc5Tjh0aitlQWdLT1hZOHQ1OElEUzViR3k0QXg2SmRH?=
 =?iso-2022-jp?B?ZDRTSDJ3ZEptWE5KOVZjeWlhdHZFOXNhNzM4a2YrcjVET0hOa3lKdGZF?=
 =?iso-2022-jp?B?YnN3RHhDc0Q0MlpmcEI5SWIvWVV1TlJlSUQ4YzJ4Nk8zWDl5cFZzUzhm?=
 =?iso-2022-jp?B?QjJUUmhPRkhLNy9HTkxRdEdJK251ditKRTE2TmxSaURGamY0eldUV1Vj?=
 =?iso-2022-jp?B?ejNld28rOEkveWg0Z00vdUdBT05SL1BlNzRuMEt0MlEwUzZzTzVsM2ZD?=
 =?iso-2022-jp?B?b09OTVhyMEgxVEZHbzJkbmp2a3dTc3dpM3huYm1DZXIrUll3RE50eDlJ?=
 =?iso-2022-jp?B?Rm16ZXNkVTVPN1N4ZVJER0FPWUVZNFFqMG5iUXpZV1hKY3hhY3N2MWFN?=
 =?iso-2022-jp?B?cGRiRm0wMldxMm5lcnVsTHA5WXJiaGtqaXFKZDZsNE9mUlJnckFVayt0?=
 =?iso-2022-jp?B?NlN2bTZCYlNydFpGaXJuME9DRXR6QlVIandtRGpTYmsxQ1VOaEdZajFx?=
 =?iso-2022-jp?B?MTB1V0RLUDgyWnFReEkyUFpXc0RISVNHMHZlTUFySWtWRHBQM2FBK3lt?=
 =?iso-2022-jp?B?OFkyeFc1a1FldjI2dzBXa0JpeldrdkVyRlVKdUtldXhCdGVVUi9uWjNL?=
 =?iso-2022-jp?B?U2tQdVNSd1pKSHFhYXZRWG4vRHBreCs1dHlRU0lIWGZLa2F5MytiVmhK?=
 =?iso-2022-jp?B?bDFjUjJMZFlHbUtrZlNsOUo1R2FsSGNIa0V1OXJhWUpQZDcvUTNYZ3lQ?=
 =?iso-2022-jp?B?L3VFbitFYk15OTdpdnBXVys3VDFvWjJoSmp2ci92b0NFSCtnaHpUTnV1?=
 =?iso-2022-jp?B?dmVEM0t0eDhsRVlEMTg4ZXdxZHNSWTFQb2s3eUpSQ3V3UFI5eHdkZmty?=
 =?iso-2022-jp?B?OEZDVFBNTkhEZkxDTzFvNWt5bjFEeWNYSU1rb3ZEcUIra2IwclNkYzhz?=
 =?iso-2022-jp?B?a3FSakJKYysrSldQZWRENU9jN1d4Nll6eVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dff3c2e-3e47-4e9e-5474-08dc8633a6fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 14:19:18.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LShrdLFwIPnngniFPPuVQSAyz+85M9Qk4W2yE24boD6x6tA8JE5AcY/A+44jSPNh7/XieDC6WoEjBsHk7G+iZ6hqnm+hrEfvID1eLuXBiXRFvzCZ0AOjoxgmyfOdTzd4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5309
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jun 2024 14:19:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16128

Hi,

CIP kernel team has released Linux kernel v4.19.315-cip110.
The linux-4.19.y-cip tree has been updated base version from v4.19.312 to v=
4.19.315.

You can get this release via the git tree at:

  v4.19.315-cip110:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      80b2464ae89aaaa73b7a2daa3526c1ed9971ab5a
    Fixed CVEs:
      CVE-2023-52429: dm: limit the number of targets and parameter size ar=
ea
      CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate m=
emory more than INT_MAX bytes
      CVE-2024-35947: dyndbg: fix old BUG_ON in >control parser
      CVE-2024-36946: phonet: fix rtm_phonet_notify() skb allocation
      CVE-2024-36017: rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute=
 validation
      CVE-2024-27398: Bluetooth: Fix use-after-free bugs caused by sco_sock=
_timeout
      CVE-2024-36933: nsh: Restore skb->{protocol,data,mac_header} for oute=
r header in nsh_gso_segment().
      CVE-2024-36950: firewire: ohci: mask bus reset interrupts between ISR=
 and bottom half
      CVE-2024-36883: net: fix out-of-bounds access in ops_init
      CVE-2024-36934: bna: ensure the copied buf is NUL terminated
      CVE-2024-36886: tipc: fix UAF in error path
      CVE-2024-36964: fs/9p: only translate RWX permissions for plain 9P200=
0
      CVE-2024-36940: pinctrl: core: delete incorrect free in pinctrl_enabl=
e()
      CVE-2024-36959: pinctrl: devicetree: fix refcount leak in pinctrl_dt_=
to_map()
      CVE-2024-27399: Bluetooth: l2cap: fix null-ptr-deref in l2cap_chan_ti=
meout
      CVE-2024-36919: scsi: bnx2fc: Remove spin_lock_bh while releasing res=
ources after upload
      CVE-2024-36905: tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV s=
ockets
      CVE-2024-27401: firewire: nosy: ensure user_length is taken into acco=
unt when fetching packet contents
      CVE-2024-36954: tipc: fix a possible memleak in tipc_buf_append
      CVE-2024-36904: tcp: Use refcount_inc_not_zero() in tcp_twsk_unique()=
.
      CVE-2024-36941: wifi: nl80211: don't free NULL coalescing rule
      CVE-2024-36960: drm/vmwgfx: Fix invalid reads in fence signaled event=
s
      CVE-2024-36902: ipv6: fib6_rules: avoid possible NULL dereference in =
fib6_rule_action()
      CVE-2024-26923: af_unix: Fix garbage collector racing against connect=
()
      CVE-2024-36004: i40e: Do not use WQ_MEM_RECLAIM flag for workqueue
      CVE-2024-27000: serial: mxs-auart: add spinlock around changing cts s=
tate
      CVE-2024-26993: fs: sysfs: Fix reference leak in sysfs_break_active_p=
rotection()
      CVE-2024-35849: btrfs: fix information leak in btrfs_ioctl_logical_to=
_ino()
      CVE-2024-35969: ipv6: fix race condition between ipv6_get_ifaddr and =
ipv6_del_addr
      CVE-2024-26994: speakup: Avoid crash on very long word
      CVE-2024-35960: net/mlx5: Properly link new fs rules into the tree
      CVE-2024-26981: nilfs2: fix OOB in nilfs_set_de_type
      CVE-2024-35997: HID: i2c-hid: remove I2C_HID_READ_PENDING flag to pre=
vent lock-up
      CVE-2024-35812: [REJECTED]: usb: cdc-wdm: close race between read and=
 workqueue
      CVE-2024-35984: i2c: smbus: fix NULL function pointer dereference
      CVE-2024-27395: net: openvswitch: Fix Use-After-Free in ovs_ct_exit
      CVE-2024-26922: drm/amdgpu: validate the parameters of bo mapping ope=
rations more clearly
      CVE-2024-27020: netfilter: nf_tables: Fix potential data-race in __nf=
t_expr_type_get()
      CVE-2024-35982: batman-adv: Avoid infinite loop trying to resize loca=
l TT
      CVE-2024-26997: usb: dwc2: host: Fix dereference issue in DDMA comple=
tion flow.
      CVE-2024-26984: nouveau: fix instmem race condition around ptr stores
      CVE-2024-35973: geneve: fix header validation in geneve[6]_xmit_skb
      CVE-2024-27001: comedi: vmk80xx: fix incomplete endpoint checking
      CVE-2024-35955: kprobes: Fix possible use-after-free issue on kprobe =
registration
      CVE-2024-27008: drm: nv04: Fix out of bounds access
      CVE-2024-35847: irqchip/gic-v3-its: Prevent double free on error
      CVE-2024-26999: serial/pmac_zilog: Remove flawed mitigation for rx ir=
q flood
      CVE-2024-35978: Bluetooth: Fix memory leak in hci_req_sync_complete()
      CVE-2024-27013: tun: limit printing rate when illegal packet received=
 by tun dev
      CVE-2024-27396: net: gtp: Fix Use-After-Free in gtp_dellink
    added commits:
      CIP: Bump version suffix to -cip110 after merge from stable

Best regards,
   Nobuhiro


