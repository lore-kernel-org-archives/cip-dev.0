Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990FAC44500
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 07:22:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32133.1769066517167604801
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Jan 2026 23:21:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=aBsS1bQJ;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1769066513;x=1770276113;bh=rbS5eLMJgx2cI4Ov1dV0phHEmhf60rMCNuALZ
	EW0mL4=;b=aBsS1bQJ3i2sg9CRiPQ6lOSJeoUjGGP2YRxFDP5AMcYuJ5nsRcxoMM9mS86ZtjN0D1S
	y+K3a0RS4W3D3lDs3oCkIXheaTAHc6jRqndTo/4wEu4RWkPxIGiIo6LmoFO60+2rqvh7zwiAHdRrq
	yR5qbGY8wvAhX3q6wiDwxJxgAp8REkqt5e4RRcqGuK8eTTk1SAdrnEQ5turcD2e6Do/i09abBcl1x
	5ha0HoKeKaYo7c8PCf6MkHcB6zHTfDY2u4lFMAcGH7BPgGAEBTHorYNGMBHwoGpByrSeQeojPMWhC
	JEOWrMypzI0n62YRh+4u7I3POKL+ezCXZ2qx5TU9QRPw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60M7Lrt22197092; Thu, 22 Jan 2026 16:21:53 +0900
X-Iguazu-Qid: 2rWhaDm0CpWiKrOFa5
X-Iguazu-QSIG: v=2; s=0; t=1769066513; q=2rWhaDm0CpWiKrOFa5; m=C9xSX0kS+rVdj2X52l11f4UVgmLLRBGs6rjgK1aTwvA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dxXYr6GGvz1xnZ; Thu, 22 Jan 2026 16:21:52 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyQw3xTo3UYoY95TSAK1K971gtt9rmRuQfLqVfOpKz+xoXvljfXGde804kH5ipcEQopXq7Od26wuHZ+EbOMyRoEYGUt7QLbBJ50uEnzBN7nmdJ6XOZA8oLSTfK8PW8elbWQRXXKvl/YiOYX0mUk64cqnShJDOdS8eEZ4yRjSMrT1CGHwvzS+bDNV9FQycgRvCeujwKRxNo/yTJcIljzOsTUjR3fRBQNTt3xfpXyLxkypJK9VCuRwVwZVLBVkWftp7Af45Efz1haOwPP3XnjU7AN+yIdhCqRlV08cdq/6kW6r1Ox4k+Vz5I3cVCSOhE452cLskCvyrM/CXuTESekPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbS5eLMJgx2cI4Ov1dV0phHEmhf60rMCNuALZEW0mL4=;
 b=aOlsc+/x7lkHaVJL20vEqiRDJhLw6GRzUDnmSZwuTDemjCWq69+4AU/UVq1VF1WuCA9LBq2w3rAGhjk0xWEsckvjjTNS1i0mHjaA0mWZr0m4eHu4hZ+OfXHd2sqIggknHlqERZFC5FuC+FEI/RSjLm8Vq3b0qmj8d5PpHbRrm938fn8CLXA61fy0AhlF0VRV7cK81Q57Myg01MoOxdwULQ6TzyDtooaENjXMvMxILneLf5jHkqoj+TLxCBvhccataA3bnrWTZnKnU9zjXRgRJ1m6qoaCan8GVIbq9t3mkbScKjMMGOK1PF1r9LIhcdHmCLbrRNXf7fbbPbrAYBVL7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHci2PlfJhA/qFAm0aQbU0QVYeZBbVdxyFw
Date: Thu, 22 Jan 2026 07:21:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E9821AE6CE602570697DCD97A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <9c55b85a-a802-40e5-bf1f-29cfad4dbb9e@siemens.com>
In-Reply-To: <9c55b85a-a802-40e5-bf1f-29cfad4dbb9e@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB14939:EE_
x-ms-office365-filtering-correlation-id: f8016f4d-30ac-4aa5-fb6d-08de5986e85a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R1diYzhFVEQ4Qkhtcys4ZU0wQ2QyU2RzUUxqdHYvSE5ZdUJ5OG9aOFE4cmFm?=
 =?utf-8?B?a2F0a2kyRFFNbnZ2UlpLcytjc25uR0JmN0E4NUJpdHI5UEJzMVJaK1JTdk9O?=
 =?utf-8?B?dC9WSTkrL1BMNnpPMmxISVY1TGlZZGJsMC85S0FEQW1odDhyTkRqcG5nQVVI?=
 =?utf-8?B?NUpRcG1FZWV6eDd0Mmx5MVRuNmJiNVk4YkRBUzB5WEE2S1hibG9INk52Q20y?=
 =?utf-8?B?WmpheFhHZ1Z1NllkT2hNdHg4aklOYXR2MjhXTTFmOVl4WXBkekFhS1R1ZlhL?=
 =?utf-8?B?bS9vbDhXdVpwY3BhelNjcmZUYVA3dUNnTVZoZWhCbVdlUkxKL2NoNWFFSGNS?=
 =?utf-8?B?eEJuU2VVOHNxQkVHLzRrc3NHcnRESmpva2dZMkI1ODVuNFNpM1FmTmxBV3Zm?=
 =?utf-8?B?blNyeVpHWmtBNmtCc200YkNVNGt3NDdqZUQ3cGJNdU9JNyt5QjBraHBWTXZI?=
 =?utf-8?B?QnpnMkJzemdYMW9hUUVsdDdIUEZWdW5tNDBBT1RUdzluVGxzb2pnYnpNWHA5?=
 =?utf-8?B?MkF2Mk9pTWFVc1BBZ0UzcDRldVArQ0hyUE9mM2tCQ2pzbWRON05CbnRFc0lT?=
 =?utf-8?B?M2hrdjlyMFNxWjM1K3p2OCs2WFZwLzNnK1ordTFFb2ZMUU16OXkrQm1EQkhQ?=
 =?utf-8?B?YU5VM1BZQ2grQ0lyc1dTQ2Y4UlNnZEFla2p1NUViNDJzc2RyVm1XY1A5dk5H?=
 =?utf-8?B?MjduUXYyeW11ZFdvQ1R1Z2MzcUZMN2I3aURtbGMzblB3VmVlSWRCc3dkRStl?=
 =?utf-8?B?S2F5ZU5qZlZPenpNd25jSTBnb2RTZEc0bDY1TzFzN1NpQ0ZiNE1vU2VPVHg4?=
 =?utf-8?B?R09tMVlHL1N3RGdQc2hWUG5Fd2xwaStSeUtLRTVHMElvaVh1MXhzVTlkR0lP?=
 =?utf-8?B?c0s5RUt6ZXpscmIyRGVLNm9RTTF2VS9KOENKN3hQMkpFMk1TM1ZTcVN0OXB4?=
 =?utf-8?B?T3RhR1pCci9EQlBDa0FsUUFTdmVHaERyWmxvM1dtNjRuU1RqRXZWdGZRMytw?=
 =?utf-8?B?aU4zK0dOS2VCTit3Y1J2V2ZBR2EzRXVVZHpyeXVLUHpvMHM3VHZYZGtaZStZ?=
 =?utf-8?B?VEZ4eVNtRHk1VTgwQkw1aElDanQ5Yng5UGZDaVlTT0lmTDExRVlFWmhZOEVu?=
 =?utf-8?B?L1hOTW92aDcvMGFIUCtBcmJ2bC9FNDVZS1RUOGpjYUthaCtnR0JkMWdoOWJG?=
 =?utf-8?B?dUVaVWVIMDdma1lHWHUwTTVsMWdWSSsxbmVEQkhESHloalA1T2RMRW4vSXZh?=
 =?utf-8?B?SkhKM1NOS0xXejF3R0FZeVl0RVV1UW1YejJRNmF5OGRsVmdxelRuaU4rdGRi?=
 =?utf-8?B?UzNVWUpWaERmZGdMSEV3THFFUDZ5VkMrNER4U3J4bDdjajBQVTV3TjQ1U0p0?=
 =?utf-8?B?Y0p3WHhKS0pqSzlWdXFWWEZjUDJGYVJacTdjV2ZKSUxsMUd2cG90dC9GNHhr?=
 =?utf-8?B?bmQ1OGtNcVVUc1huWTc1MHhKS2hQMmdJWTRMUWhhWVo5bGpSNkUyR29HMkhR?=
 =?utf-8?B?WUhuZkxoeUx0S3hnMTdVcHVaTjdHRk4yZFpSUnEzeHdRYUJIVHF2cFVxVnRz?=
 =?utf-8?B?NzRqbFN6ZElaM2ZoV1F1Sno4TGQ5bmw4cElGd2RHcGpwazhMS1psM1dVQVR2?=
 =?utf-8?B?UW9JS2dRaEtxdmQrc2dzd29zZHRZbWxqTWZ5d2ZBUWplR1V6VWhrZE9ucW56?=
 =?utf-8?B?VjR1RDNuZFZMenQrVDJBWHhEcE96TURBMytFK3JITlhkVjlPS1l5L042OERk?=
 =?utf-8?B?RkpvY3d5SlBSTnI3OWxSSnR6ejQyc0hLOTAydDk0NG9lc0FLVlpNd1NIZWxF?=
 =?utf-8?B?VHFqRmUxZHI1Rm8rOVN5NHBxaHZMdGViYzRGaEk1TWNYWDFFSTVSUzZ6N3k4?=
 =?utf-8?B?SkFwUzhoZWJyM0IvbTFHRnBDbmQ2UzBFUjVZYkRYK0tEVlk2U09iN3NrNEtM?=
 =?utf-8?B?eGZYTWplckVkR3VyZFlqWUYrOW5kdzRiQ1ZZMk0rMlFiY25hKzZjVE0zdWUz?=
 =?utf-8?B?ZXhrL1poRWhBZlJ3dGEzUVQxMU1pWnRwY25zY2FsdUlPYXYwYndna3ZxWUVh?=
 =?utf-8?B?bGFmV1dzcHJZS2FkUzBNczA3ZER4UEVEdVFRS1Jvbjk5QjF4bVgxRlBGUXBS?=
 =?utf-8?Q?SzQoVcUFOY8UAn6RyQYMo6m60?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bDVhbko4Vnc2Ry9vbWZJZ2U5cmZVTnVqWi9aUm1hd09PcCtjdzAwaEI5a3Nh?=
 =?utf-8?B?VkpEbjhYdXpTS2FpQU85RnBveHF4NVhWNlEvZ1V3ekNCN3luSERvWWh5TWMy?=
 =?utf-8?B?UG9jL25vK2RaZGxGeG50bGgxRTd4bFFoUVA3ekQ3NFl6Mjg5ZFgwUzcxWVRs?=
 =?utf-8?B?Y3RsOFg2cy96L1pvOWQra2pPM051OUJ4bU9pOVAxM0hydXJpamVMeXR3L01h?=
 =?utf-8?B?OWRDR0Ztb3BwaWJZS3dxNElNZFpZRi9DWGY2K3N5SzNUU2dUQXFoMmQxU1c5?=
 =?utf-8?B?YWRDcEF4SzlSWVJjU0l4SWRMR3NUb21OcnRiT0UwNFBEMVk4cmZwNGk4VzZh?=
 =?utf-8?B?REdpMFBrSFpFRVliaDlFWlgyVUtSdEpOOUQrU1NzSUJvU3lJM2RuSlJNbURK?=
 =?utf-8?B?cTZ1cE4zL1Z3cndCLzFjQytEUzd3cEJJb0lybDQyYVFKcXl1NUsvQlNHVktF?=
 =?utf-8?B?Yit1RkFDc1QvU2hSY2JFczBXNytOU01lYS84OVlnRm96czhjUG9qTDRiNjMv?=
 =?utf-8?B?THhsTzNWY1NxNUw4WTAwYThEMG13T1R1VTViRmorTUFQdy94a2FabTZUNElP?=
 =?utf-8?B?c28zUjF6RXFEakhNaWlpK0tTZHd1aU5nckx0eThBZUtBWEZPaEN4cVRpakl0?=
 =?utf-8?B?dUlidTRDUG9KRlovMU1XeXBWVmlzcEU0b0w4aFVFYzZSTGdrMVo0dmdwM3R1?=
 =?utf-8?B?M090R1U3MFJZa0I5WndzOXVDOWNQMktIVW1MdlgrL2Fqdm9ZZ0tWai9nYVRj?=
 =?utf-8?B?dXB6TWQvZzlHOTE4YkF6N1JkK014ZU93OTVrNHFJZDl2c3ZEd3JmSWxpTklj?=
 =?utf-8?B?QlpuaHZwZktweVAzVkRMUFhiNCtoZnNtQVBiSkxSTHdxby8zbHZ0SGJXYm1J?=
 =?utf-8?B?TlVJczRFYXpmV2JSVGJqcDc0RnZMaDhvZzdLTnVNV0lpcDRQSFFxREJKc0x3?=
 =?utf-8?B?Vmp3bEsrR2djNU4rY2NjVnpRcU5nTmw4ZkdtU2ppbmJVbGgrdUpkTE52VHFW?=
 =?utf-8?B?c0M4RVlCem4xT0w3TGFyWThsOGJFM2dtV0pkZVI5NnhGdkdnMDA3NjA3OUNk?=
 =?utf-8?B?TEpRUUlHaXpsK0tibnVmYTJMMFdBMStjWlRpdUF4dEtaclpvNXIxNGFsMXh0?=
 =?utf-8?B?azkwS21NdkRqZ1NxMGx2ZzlXOTVsaGMzQ2FFdnhHZXFhOTA4NXlnYUtmT0pI?=
 =?utf-8?B?VC84T25YRkh4UWlaLzhDRm9EYVE2SVViaDJMUTQyTytmazhOeThTM05BMi91?=
 =?utf-8?B?bWF3bFY5ZnhnUTJWRzVmenVieURqSEVhM2FvZ1hTd1RKaDc4czZmbVNPaEx5?=
 =?utf-8?B?Ti9nT2pSUHlLWFF2WGE2Y0lDeUJ1Qy9hUmFnajgrdXc4b1J6Q0hXdGRxeThw?=
 =?utf-8?B?V0J5R1NVWEs0QndZNjNuNVFjN1RDOWN4WUNGMEIyYjNObzV6alV6bG00YWNa?=
 =?utf-8?B?OUIxWHZtWGt0QVhQa1FNVkp0Zkx4Y3AwSU1hdURYVERIaHlDMWJmYThUVDNs?=
 =?utf-8?B?WkZaZitqeENMVU16Q0JYSnFLVE5yRThIMEwxdEF2eCtzTU5GU0xBQ080elNZ?=
 =?utf-8?B?bmtJdGRTSnY2QlRWbGtyQTVtOUlYU01yTmVhVU1UTzc4d1ZGODBRWDU1dFBr?=
 =?utf-8?B?Y0d6TVNSUmZKeFd2OERRcGROTDJPeDkxb3RVbmlpT3FHWEVzN21WRXpqZlcy?=
 =?utf-8?B?OEZoNHV5M1lJYWo1amE2LzhRSWppSHZOR0hYd2pTalczclNYME0vYmkvLzJk?=
 =?utf-8?B?TlRoRG1ncExqR1ZpdkdtYWRKTjVTcDZ2TzdtNERkQnY5WnFxTWlOdjVoZzlJ?=
 =?utf-8?B?TjhkbEx3OVU2SUozaE9HbVBHTisxQXZWTjBXMzBvQ1YvT1RUL0ZxejdJWjdB?=
 =?utf-8?B?T3c0cTBpc2l5VTdCd1JCTERWTlJmRnFnZEJEbVBKbHNWMTRKaXc1ZnFwa0Uy?=
 =?utf-8?B?L0toN2YxSEgybElwaWlnenMvOEpwVlB5eTJhcmFHakhIdlJtN0I3NFowTjVM?=
 =?utf-8?B?OVpJbzMzZnVrMnJLLzhqdk9JMWg2YlR5WXdkOGNQK2hsT2wzNmZSTnJmbVM1?=
 =?utf-8?B?R0dTSXY3ZFlUMkpRdFRxaGVzRmlrcnhINCsyV3plbDVlcmZYdWgvRUdJcG0y?=
 =?utf-8?B?K3d2SXI4Z25VNXpuVkFaSmprUXp3d2FXbTJmbDRvaVI4M20rWEE0VFMwZ2Iy?=
 =?utf-8?B?eXhRems2elpYWEF4ckJISHdmbnIzdUhNS0VnYmZVbDI4ZTRTaTBLV0Y4RC91?=
 =?utf-8?B?YkZ3OGtCVUZRclpPbXNRRXgyS1VFSHFZN002VS9UMVFTSU5QWXNnV1FYcUw3?=
 =?utf-8?B?RTBhamlXNFZEb2M0ZzRkSGJwOWJ5NlhrV2kyeGhqWFZkZktjRFFoVi9DKzRa?=
 =?utf-8?Q?lGgW0VhFIIO1pgzg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8016f4d-30ac-4aa5-fb6d-08de5986e85a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 07:21:49.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/W1I4l0sXHJLYPOUHc5Da0hQqZvh1rLorLM3eMP7xQ/qWophPW4QjVbp/UyzED3Lb7nWPq+cRK8m0ewpV4xuoTb1IlSKrG8OqUZQCiFj6mihEQ+QDPmkWlJN8daNaCc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14939
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 07:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21695

SGkgYWxsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGNpcC1kZXZA
bGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4gT24N
Cj4gQmVoYWxmIE9mIEphbiBLaXN6a2EgdmlhIGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KPiBTZW50
OiBUaHVyc2RheSwgSmFudWFyeSAyMiwgMjAyNiAyOjU2IFBNDQo+IFRvOiBjaXAtZGV2IDxjaXAt
ZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NCj4gU3ViamVjdDogW2NpcC1kZXZdIENJUCBJUkMg
d2Vla2x5IG1lZXRpbmcgdG9kYXkgb24gbGliZXJhLmNoYXQNCj4gDQo+IEhpIGFsbCwNCj4gDQo+
IEtpbmRseSBiZSByZW1pbmRlZCB0byBhdHRlbmQgdGhlIHdlZWtseSBtZWV0aW5nIHRocm91Z2gg
SVJDIHRvIGRpc2N1c3MNCj4gdGVjaG5pY2FsIHRvcGljcyB3aXRoIENJUCBrZXJuZWwgdG9kYXku
IE91ciBjaGFubmVsIGlzIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiAgICAgaXJjOmlyYy5saWJlcmEu
Y2hhdDo2NjY3L2NpcA0KPiANCj4gVGhlIElSQyBtZWV0aW5nIGlzIHNjaGVkdWxlZCB0byBVVEMg
KEdNVCkgMTI6MDA6DQo+IA0KPiBodHRwczovL3d3dy50aW1lYW5kZGF0ZS5jb20vd29ybGRjbG9j
ay9tZWV0aW5nZGV0YWlscy5odG1sP3llYXI9MjAyNiYNCj4gbW9udGg9MSZkYXk9MjImaG91cj0x
MiZtaW49MCZzZWM9MCZwMT0yMjQmcDI9MTc5JnAzPTEzNiZwNA0KPiA9MzcmcDU9MjQxJnA2PTI0
OA0KPiANCj4gVVNXZXN0ICAgIFVTRWFzdCAgICBVSyAgICAgICAgREUgICAgICAgIFRXICAgICAg
ICBKUA0KPiAwNDowMCAgICAgMDc6MDAgICAgIDEyOjAwICAgICAxMzowMCAgICAgMjA6MDAgICAg
IDIxOjAwDQo+IA0KPiBMYXN0IG1lZXRpbmcgbWludXRlczoNCj4gaHR0cHM6Ly9pcmNib3Qud2wu
bGludXhmb3VuZGF0aW9uLm9yZy9tZWV0aW5ncy9jaXAvMjAyNi8wMS9jaXAuMjAyNi0wMS0xNS0N
Cj4gMTIuMDEubG9nLmh0bWwNCg0KSSBjYW4gbm90IHBhcnRpY2lwYXRlIHRvZGF5J3MgbWVldGlu
ZyBmb3IgcGVyc29uYWwgcmVhc29uLg0KDQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAqIEtlcm5l
bCBtYWludGVuYW5jZSB1cGRhdGVzDQoNCkkgYW0gcmV2aWV3aW5nIDYuMTIuNjYuDQoNCj4gKiBL
ZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQoNCkZvciA2LjEyLnktY2lwLCBJIGFtIHByZXBhcmlu
ZyBpdC4gSSBwbGFuIHRvIHJlbGVhc2UgaXQgdG9tb3Jyb3cuDQoNCj4gKiBLZXJuZWwgdGVzdGlu
Zw0KPiAqIEFPQg0KPiANCg0KQmVzdCByZWdhcmRzLA0KICBOb2J1aGlybw0KDQo+IEphbg0KPiAN
Cj4gWypdDQo+IERhdGUgdGhlIGRhdGEgaXMgY3JlYXRlZDogVGh1IEphbiAyMiAwNTo1MzoxNCBB
TSBVVEMgMjAyNg0KPiBsaW51eC00LjQueS1jaXA6IGludGVydmFsIDMwIGRheQ0KPiAgIGxhdGVz
dCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogVGh1IEphbiAgOCAwMjoxODo0NyBBTSBVVEMgMjAyNg0K
PiAgIGxpbWl0IGRhdGU6IFNhdCBGZWIgIDcgMDI6MTg6NDcgQU0gVVRDIDIwMjYNCj4gICBTdGF0
dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuNC55LWNpcC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAg
bGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBTdW4gSmFuIDExIDA5OjU1OjExIEFNIFVUQyAy
MDI2DQo+ICAgbGltaXQgZGF0ZTogVGh1IE1hciAxMiAwOTo1NToxMSBBTSBVVEMgMjAyNg0KPiAg
IFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+
ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBXZWQgSmFuICA3IDAzOjE2OjU5IEFNIFVU
QyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogRnJpIEZlYiAgNiAwMzoxNjo1OSBBTSBVVEMgMjAyNg0K
PiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcC1ydDogaW50ZXJ2YWwgNjAg
ZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBUaHUgRGVjIDE4IDExOjQxOjI3
IEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogTW9uIEZlYiAxNiAxMTo0MToyNyBBTSBVVEMg
MjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55LWNpcDogaW50ZXJ2YWwg
MzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBGcmkgSmFuICA5IDA1OjAy
OjE5IEFNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogU3VuIEZlYiAgOCAwNTowMjoxOSBBTSBV
VEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55LWNpcC1ydDogaW50
ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBTYXQgSmFuIDEw
IDA3OjM4OjQ2IFBNIFVUQyAyMDI2DQo+ICAgbGltaXQgZGF0ZTogV2VkIE1hciAxMSAwNzozODo0
NiBQTSBVVEMgMjAyNg0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNi4xLnktY2lwOiBp
bnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IEZyaSBKYW4g
IDkgMDI6MjY6MjUgQU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBTdW4gRmViICA4IDAyOjI2
OjI1IEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBsaW51eC02LjEueS1jaXAt
cnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogV2Vk
IE5vdiAgNSAwNjo1MDoxMyBQTSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRhdGU6IFN1biBKYW4gIDQg
MDY6NTA6MTMgUE0gVVRDIDIwMjYNCj4gICBTdGF0dXM6ICpMYXRlKg0KPiBsaW51eC02LjEyLnkt
Y2lwOiBpbnRlcnZhbCAxNSBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNlIGRhdGU6IFR1
ZSBKYW4gIDYgMDI6MjU6NTkgQU0gVVRDIDIwMjYNCj4gICBsaW1pdCBkYXRlOiBXZWQgSmFuIDIx
IDAyOjI1OjU5IEFNIFVUQyAyMDI2DQo+ICAgU3RhdHVzOiAqTGF0ZSoNCg==


