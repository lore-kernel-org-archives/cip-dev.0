Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C75AC369C7
	for <webhook@archiver.kernel.org>; Thu, 17 Apr 2025 06:05:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.2476.1744869939569788604
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Apr 2025 23:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=wfOuAR8N;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.135, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1744869926;x=1746079526;bh=W6dnliBoi+OD58mowRgNF+SSp4OlzZUUfKoPMuw
	bn2Y=;b=wfOuAR8No2KT1ZYg76h0UxEDVvoQzQkSItZhOluDzKfI20aYI2p65IYn484AFLF+rwPTU
	g3sotyMcQbSAFORnFPlRyw3dLoU4tRmRoxCiTBVXr7oxTgpGSLQlHI9ITqEayiM30RmjzJuaD8imI
	tKo5xkgDF9nwNGROc82fryc1byISaFEwrObR//XWq+9gIQj8KXmq55XZUI4FdtB9emgQj4cvcWyj7
	8zV24kzorPbFxk637hpUDY+/wJuKk+VhZZoawP6O7VWIpJI2oq5Nk7TiZxtItwkOW4SdLq005FTdw
	7MK57VQnOnIc9EYMvQlJ7fIlCNEct6p5mhyai7E1yA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53H65QIx3486196; Thu, 17 Apr 2025 15:05:26 +0900
X-Iguazu-Qid: 2yAbj3N9ZToJiCpfSp
X-Iguazu-QSIG: v=2; s=0; t=1744869925; q=2yAbj3N9ZToJiCpfSp; m=gpWfrGDUJwkE7slie6i1moF1QAxiWMLCyK6Fhpt/7Qs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 53H65NuI3769875
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 15:05:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsWe6EaduBash8uuQZkKy500XcQJ2+3P++ugbeyyB1fzilWSNsr1/JY9jatVXlVjgE9dbDg08+6575jDmoYxcvevsUjYrRTIxU6mTirIAFXQPR3wID+krR+Mz5XvDuUytz4+Zd6s8sZejOv2ublVHB9StTlbxZaBSwxP7fq+UUjpN7doyNNaBb5F3N1gVZk1fMPaHkAkWMX2u4ri7NaRNuMvzg8y2Hi8BsV0Ro2BJrAU3KJ+RZiFaLWEiRo0PdkMphfUf6MFPc4oH59+ZYruv9tTENap/aH6Suf9B5adEY26MQIMmQfE8qjfqoG1DnnT8/eNc6FKVuqRGhjSV3j8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JslOLl2MAEWOVHHirnulOHvdABfZ7UXT8aWrJhweg+4=;
 b=NiOiZEmUXG8t9we++2Xk7sINO2+6Jt5WdU8HkaVobeVK3gm8DFQIT2q0HCi+pK97UmJyuVlYjCSLAG8SYvBbs1nndIYSvXSR0971+AgbCIwbRjqfXuRDgOCCkFk/or+YTPTyGKxIItlA8n1iRouOfv0SqgrlbAVW0PylWleUrEV1w5s2hS563dhGq0QB/i6J7iJDqmp+X/UFDPvtoz7Pku7blWa2qjeBGeGSdwSrNzDFXiK4s6r9ZFWZ+JAUDChWmaoQI5XxD4rw6TeM+92g8+bjBMRcAdZNTIrp8LYupufFyt2/zimpZk5zJz2AON5qTo0j+FyAoLjHASaTmXOgeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Topic: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
Thread-Index: AQHbpUgQJ4XZlFPttEOjVvE3iV3PDLOmMT4QgAFA6XA=
Date: Thu, 17 Apr 2025 06:05:18 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818A6DBF8C7D899210ED72592BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1833151A32081021.4816@lists.cip-project.org>
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS3PR01MB6776:EE_
x-ms-office365-filtering-correlation-id: 70e5090d-d1f1-41c9-e6ba-08dd7d75d432
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Q0tvbHdiNndJR2RNWkNUWlFkTVI4RjFFbm5WME1RVVJETkJjWVhKVVR0?=
 =?iso-2022-jp?B?RzQ1SG5GaEhLNGE1Ymt0ZWNXOExCakNZZ3UvblJRZDUvaFM2dC9hMmN4?=
 =?iso-2022-jp?B?M2ptaEtMS01LRHNxUnBlRVppRU5RSXNoR3lMdmtsclUrdlJnQWVNRk14?=
 =?iso-2022-jp?B?TlEyUlZqNDZMRHhXVmszcGMxWWxObWR4Z3gwaG50NERha2hZcHJEOFFL?=
 =?iso-2022-jp?B?Yzd5cFVjaWdiU240ZERPeWRkcjhVUnJidmNKaW5ESzVlRitFTFVlaXdT?=
 =?iso-2022-jp?B?T2ZJRlJkUnFBZENQRU1kVDdFWWUwYTJnT09qd0tKbzZMdFhvaGpsUzhJ?=
 =?iso-2022-jp?B?SVhxRVZKVTM2bWxCak0rb0xZbEtueGVJZ2FKVXUxSGJUR3NrUG1MNmpq?=
 =?iso-2022-jp?B?cGgxbVR1NXE5Y2ZRRzh6ZXp4dlVXOExPQmxWcStzSG1zOEdyVHBZN0hx?=
 =?iso-2022-jp?B?RkZZR0lqSFVvTmpqR1BZMXM0c0ZaMDZoa1dESXJaM0lyMUliNmU4ZGpQ?=
 =?iso-2022-jp?B?ZmVBK1NkZllBSFVieW9DRjNsK1pGajR2eUZqcGh0RWxxbGFCdC92V25x?=
 =?iso-2022-jp?B?dW1LU0g0dWxzZGdoZnpGT0ZQYnRVOTV6dWVpb1huSjhyVDM4SlkvQnMr?=
 =?iso-2022-jp?B?THpGYXRBd1BkYzZCTVJzQnZhR1ROekE2cFQ5QTVpcG01dTNkeTdtRVhB?=
 =?iso-2022-jp?B?QkpDcFlRdFdDblRBWHJ0OEc1UzJGNHBHeTR0MGhNM05CUmJhR2RiSWZJ?=
 =?iso-2022-jp?B?Rkh1QkVEaXh4eUl4V20vTGtyVEl0Z1lrakE3dXRaamRXQjhsOTBacUEv?=
 =?iso-2022-jp?B?Y3hDcEJoUkxwK01HRFZLYmlKS1RHSGd4R3pjS3ZpMUtoTERvSzBlWkFm?=
 =?iso-2022-jp?B?cVVLUVl2VUlvUkRFWEdPdjMyNHl6cWthclRFdHY3UkVrV2crRE5vU01q?=
 =?iso-2022-jp?B?NlhQZjY3czRYenBYZkhWWXRZMUZWMjIxK2IzcnRNeFRmU0dPMGpnMk5Y?=
 =?iso-2022-jp?B?TFc2ZktoYzVKVFcrT3k2dTBPcy9MejlhT0NIanZiSmpmcVhkVGcxOVcr?=
 =?iso-2022-jp?B?eWVHejNWUkNTTnpaUSt2aStkTm5nSlVrSER2REJJQ0dDWlNRaXNFbHls?=
 =?iso-2022-jp?B?eXJmWmc0RFBtbllHSjd3RFdOYUt0ejVkcDAwK0F0SWc2S21HL3RJQTVa?=
 =?iso-2022-jp?B?NjNwYXhBWUoxQ09jMDNtY2cwNHFaZDJNSS8rY2xFUUs4Zm9NaEpGVWRD?=
 =?iso-2022-jp?B?bE5jSTRMT213QmltaVRsTnV0SW8vTFlnbWYwZ0c1bGFqUUMrZ2JvOExX?=
 =?iso-2022-jp?B?MDQ5RXdMZVZvOWNlU0xmdVRRd0IxUDZ2MkNXOXdsN0dBbkFTSXp3V25w?=
 =?iso-2022-jp?B?V3pxaFROT0hPaEtCaXl5WThGZHAyWnp6S1NraUdOY29kdjRNTy9WNVZS?=
 =?iso-2022-jp?B?UUhFd3R6ZS9lS1krS0VmOFB4Zys5OG1wZnpYZWpuVDh3TzRXWVNkUEVQ?=
 =?iso-2022-jp?B?MXRjMnkzRnpYMy80eloxSXlnRHovOUR6ZTloUXRkYVlHQys4TzE5MWNk?=
 =?iso-2022-jp?B?TjZjYWpvTXZBY05jWDVVQWdnaVducUpSbS9FaW0wL0xvUzhleTQ2N09z?=
 =?iso-2022-jp?B?MWFHdTBobEYwSko5VXVTVUZWNkN2c0lLRjlhdkxCZUlYbzhWUUg1N25Y?=
 =?iso-2022-jp?B?MDBCdFlFMFVrTDBveGNwRDVJT2pDbm85WUt5d1dnRkdWN3NRMDRQaHlo?=
 =?iso-2022-jp?B?SzM0K1pKcURqakM5QUV3TWF0TGloWWtIQmVORWdkWWNQeFY2c2FVeEJI?=
 =?iso-2022-jp?B?QThPZ0VFMU92YnNjNFpZQ0s4dXl2dURsTWN3Nm1CZitiS0RjVUNUMW0z?=
 =?iso-2022-jp?B?YXpNeW1qak1lMThFbXFwS240SFFjUk90TmtLeEp2Wml5THpsQWYyNkdn?=
 =?iso-2022-jp?B?dW5YN0xnV0pUbzVJcXZ0MjR3TU5tRjVNaFNQb3RaS0dVREdXMTVRM3Y5?=
 =?iso-2022-jp?B?d3c0L1pvM0JoMnJuTnE2dU8yZU1EY0pRUmxqOGxDT1FJcjljY3lPS0Z5?=
 =?iso-2022-jp?B?M251aXd2TTh5eUcvN2U1N1ROSXhMUFJBWWwybHBKYVFRZGdCWHRMbjRx?=
 =?iso-2022-jp?B?WWJOY0ZoaWZwbi9KNy9UZHArTndhei9NdFNIY2I3ZkRWZTMzWkFhU1Fh?=
 =?iso-2022-jp?B?T2d3PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SXZWLzhUMFBROGpZWTJPK3ZGb2tFRmdUVzk0bDk4akx0Y240cmNib3gr?=
 =?iso-2022-jp?B?WlhhVW9EOTlNL1puUVVXbUhES3B2a3lqaUYxRUMzSGVrMllhSkZSSXU0?=
 =?iso-2022-jp?B?L0JzWExDTzlNem05cjl3eG1hNUN2SW5zSWp4cWZVbEF3RHRvS3FUd212?=
 =?iso-2022-jp?B?QU9BSGxwcXZTYmFaU2s4MjcxQTViYU5GWE1XWXN4TGFHZzE4VzBwL2pR?=
 =?iso-2022-jp?B?ODhyTy9uRWNqZjdYY2dDWE8xYis5OXQ3Rm9uc3g1RFZiVjl0ejhJMVFZ?=
 =?iso-2022-jp?B?azVQdzJwekVVVFlUbDRFZTdjc2p3OFNreFhjRUlPMnZCaDNCaHorZkRx?=
 =?iso-2022-jp?B?THhMNXlBLy85R0YwcGhyZllIL2NNcTU5Tnh2Z3V0ZDJZVUNGZDJQdE5R?=
 =?iso-2022-jp?B?RUtUYk92NVlJQzFkMnIwUFlpMnljSndZMlR0MlQvSll2dlkyeUNadEpO?=
 =?iso-2022-jp?B?ZzJETUQ2YW0vbG1vMmV2QTlZd3NHQjNzNGMzN0VxRmRmYkRDR3JqMU1u?=
 =?iso-2022-jp?B?emZNOFIydytaTzBqOUdpWUlYTkM5dlorZ29XUFdnbDZJaGRTUmgvK1pW?=
 =?iso-2022-jp?B?UUFhZTFJejZYeTM1QkZXZmg5ZG8yRU9td0s1UkxqMWE4Ny9NQkFmNzVt?=
 =?iso-2022-jp?B?OE16a1N1b0xzYWlwVWttOWtOR0dzZHVEMjJLUU8zYS8rVnVOS21CWm5X?=
 =?iso-2022-jp?B?QUxydDVhbU8wczJsanY2dU9FQU00TTlxSEhKYVovRGFwMSt6VjJMdHp3?=
 =?iso-2022-jp?B?dU5JdS9BTGZJc016QkxTNTVqWTJCYW1nU2F5YWdMekNNTTN4RlNvRmlZ?=
 =?iso-2022-jp?B?TFAxMlplVHhaZnJmdXM4QTYvMTJHVWF4TlBiMGVxbnNhY3dncXN0OVZL?=
 =?iso-2022-jp?B?OUxMMWpqWC9jdHMzQ0hrTEMrQzZtcS9kQU0raU9JZHNUeE5kZWU0dC9J?=
 =?iso-2022-jp?B?cUpUWEE1QUVQMzkybXBOZ09LTm51L1FIb0xWVTVBZ3I2TVhVNW5zSXhE?=
 =?iso-2022-jp?B?QWpzQ3FkYzNacHpsdEpYLzBZSkJDZ3AxZ0Y1YVQzN0FVN3g0YXA0M25x?=
 =?iso-2022-jp?B?OFFieENLVVJJb1RVenpPaVo5WVlQSnExNEQyMEFtMExlSWlhakRSMnF0?=
 =?iso-2022-jp?B?TUpUK3l4NjJPU1p3bnM5Rk5rRFJwa1JDa1A2SHdjU0QxWG10dmZ6bXhp?=
 =?iso-2022-jp?B?cVpPQU5XQ1lsREZMaEducW1qQ3NLR05ONFg5SmJxd0hsZTYrS2x1TXhN?=
 =?iso-2022-jp?B?dFVwdEkvR2xZT21TNXlNZTJBTXNLVWNzVUxZQzNIdzhCMG1iTWc5RlJh?=
 =?iso-2022-jp?B?SVFxU2ltZ3pqOU1EUlkxRVZNRkRxUC9GV0pXT0graFc0dHBpam1mZzVX?=
 =?iso-2022-jp?B?TnBsOTY5T0ZYVDY2QzMyZEZNRUU2L1NZWkN4ekxhbCs4bjFxWnB5TXAw?=
 =?iso-2022-jp?B?SFp3MUdsSHhKL3ZPU1hTVWZvVXdLajl1SUV6b0Fyc0Q3MkUwWjhjc0hj?=
 =?iso-2022-jp?B?S1pLRFpuTnVVcEdYaWxlU3ViZHVxeml6UisySGM1RzFtSmYrQ0FjMlRu?=
 =?iso-2022-jp?B?dXJMU1BPWlF6cDhHcTdNRVN1RWdnWmg0Z0FQQlRPbkRDZSttWWdmTTBl?=
 =?iso-2022-jp?B?MysyUWNxWUJ4Q2tFNlJYTTkyWHBSOGM5VWw4SW1idjREVERzZG9ZQTA2?=
 =?iso-2022-jp?B?NFZPMkRCOGFzTnBTeDFzNXUwOXppU2lhY0pTMWhPMkFHZnFHZzZkS3Z6?=
 =?iso-2022-jp?B?Sk5yMnRVczVjK0JhRkoyb2dYWE5OcUlMQWVubmJwWnExR2U2TWFrSFBi?=
 =?iso-2022-jp?B?NXBESnRsdFNDOEpLZFFqZE55N0txaVlBUkNOaWYvRVE1U1JsdjJZWUlV?=
 =?iso-2022-jp?B?Q290VHQ3dWdvMzJtMUtNbG00SWM5a1lQdkRGdUdrZzdycVNsK0I2Tlkv?=
 =?iso-2022-jp?B?Q3hobTVsdUw0ZG5hbzNzQUpTU29kU01qUEdYdUUyaFFUMmxYRjdUcFpY?=
 =?iso-2022-jp?B?bko4aTRsRG0vdVpBTklOUzllOGVSN2E5VHQ4MlJxaGNvQ1ZHZEUrMG1n?=
 =?iso-2022-jp?B?cmRBaUFCRlV0NEUrSnJZOFhaS3REL2dMUjNJelJEdjNSamQvbzFCK0Jp?=
 =?iso-2022-jp?B?N3FQbFVsWjJiNGMveXZ6ZVV5a0ZKR3d0emhlUzBsT3hzNlI0VDIzNlN4?=
 =?iso-2022-jp?B?TTNkOS9LcFlKNis3eXRrYnZCQTVWSHhWaklsdWtxS2xuajhOaWZBRUJa?=
 =?iso-2022-jp?B?NDRLVlNwekhudENLcUlOUWE4Q3NDWFZyOWpMMGFiR2ZobVVRbDZvR1Vo?=
 =?iso-2022-jp?B?UjlIRDdSbkdtS1FFMVhLK2Jnc1U4TUxqYXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e5090d-d1f1-41c9-e6ba-08dd7d75d432
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 06:05:18.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASydSYK6SE/89PRiDva2hs4Mg7YLUevYUipJcBhyaqL7fkjCb55W0I0pOE0MlJqhgFv4Z69NyoSyr9w2+lPhRAKATi9idi/7Yk61mlKDA1j79fFQcvrMYacRoXEUmhWa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6776
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Apr 2025 06:05:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18518

Hi Prabhakar,=20

Sorry for review is too late.

> -----Original Message-----
> From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Wednesday, April 16, 2025 7:56 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: RE: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> shmobile_smp_* alignment
>=20
> Hi All,
>=20
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Lad Prabhakar via lists.cip-project.org
> > Sent: 04 April 2025 10:58
> > To: cip-dev@lists.cip-project.org; Nobuhiro Iwamatsu
> > <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
> > shmobile_smp_* alignment
> >
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > commit 379c590113ce46f605439d4887996c60ab8820cc upstream.
> >
> > When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
> > shmobile_smp_arg variables are not multiples of 4 bytes, secondary CPU
> > bring-up fails:
> >
> >     smp: Bringing up secondary CPUs ...
> >     CPU1: failed to come online
> >     CPU2: failed to come online
> >     CPU3: failed to come online
> >     smp: Brought up 1 node, 1 CPU
> >
> > Fix this by adding the missing alignment directive.
> >
> > Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr, fn,
> > arg}[] from .text to .bss")
> > Closes: https://lore.kernel.org/r/CAMuHMdU=3DQR-JLgEHKWpsr6SbaZRc-
> > Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Link:
> >
> https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.17416
> > 1220
> > 8.git.geert+renesas@glider.be
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > Hi All,
> >
> > Note:
> > - This issue has been replicated on 4.4-cip with older compilers and
> > CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE enabled.
> > - The offending commit 4e960f52fce16a3b is not present in v4.4 release
> > so this patch wont be backported into 4.4-cip by stable hence just
> > sending this for 4.4-cip only. Please note this patch has been
> > cherry-picked v6.14 release.
> >
> Gentle ping for review.
>=20

LGTM.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


