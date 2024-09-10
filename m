Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95769EB64DE
	for <webhook@archiver.kernel.org>; Tue, 10 Sep 2024 14:47:05 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.66])
 by mx.groups.io with SMTP id smtpd.web10.25505.1725979623113879532
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Sep 2024 07:47:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=fCX0lkbU;
 spf=pass (domain: renesas.com, ip: 52.101.125.66, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZk+0A47crBled6GXeKkeT4jnzvQiw4x77uU5jXewjdaZatXR2EUHMsGPpsfJNX/bcIKSHz30/CtknRJsuieUpHUUGndQE1C0HVq1yTzpo9rd4FyrtJ6YyedNOunQv92TXj5pamktQM1ZXjXFbBmSgL5BLfksk+5pAqBdbc6wY4eoLr3x0973qqSSHO8AOyczM78CNK0Ek6TppjyJk1xI1j/GIP2EEQQI2V6+53jqBxWtuCYYFcLM/koK07InTU8R0tCroEW+XiSQeIo/rCZUOzgNHuuvR8TiHTEKkY8KS6xxkYAiDT3SDzFdLuqi0Lp7sS6zYd8BSP85Ji9IKIGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODBNuS0JbINL6KTPzZnbqupJmaTi8FndU6p0LPUinOo=;
 b=polF8sd6BTHsl6t6mTABDIIa7NPzIRvP9HiryyX+hNiatoA3LwdvIidxjG+Xm7Y7CV9NR+DgSDzIcbtABAsYE/pqFivCXSwx2NCT4ewDcEce1XdpsP+l/5RMkmTbk7iWq1StDe05C592i+bQSEuFmsb3UsTgbJj+aRQqhY/BctWLc8HRncDy0cdhFPDRwkaaRRFJStJQWdDMZQTzhvirMes6obtUCgRz9ADWGl4y2G0BA83NCaK2w6aTpqNEFjYle4uSAlKej47qnBS3/CpeyAK2EnQ9cewLL9mgTx4bpH54fcPUtTbYWsa4//aLQjH+a53ZDuS4qz513iTzfLVdjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODBNuS0JbINL6KTPzZnbqupJmaTi8FndU6p0LPUinOo=;
 b=fCX0lkbUrtt1AbUu+vnu8dkxa+QS4QC68XWOADJfxOTjfjFgFF+84rDzoU3RvOM7TnbqnnuCyiBwcf0mnFEKQbz3kdcRTfTZ2MLiKLZhchafmw3Jq82Y6/Ke15eMvQGTb8B5Q18fH64tixbmkyOZb4RQYjDCycxBOFWelsGSGHo=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by OS3PR01MB8796.jpnprd01.prod.outlook.com (2603:1096:604:17e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 14:46:57 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%3]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 14:46:52 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
	"dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] QEMU reset issues in CIP LAVA worker
Thread-Topic: [cip-dev] QEMU reset issues in CIP LAVA worker
Thread-Index: AdsCr4TnY+//JphYSB26Q1N8R60kZwApm4AAAADDwJAADSKmAAAAqz7Q
Date: Tue, 10 Sep 2024 14:46:52 +0000
Message-ID: 
 <TYYPR01MB12402EBD6CCB2A7A2D90E3EF4B79A2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB61031B36A1BE2249B2F4CA2FC2992@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <84bf903a-bfaf-4570-af77-b424dd82e9f6@siemens.com>
 <TYYPR01MB12402090C6FA11A9574C6D267B79A2@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <8d40db3f-a411-46e7-a26e-8be159f6f67d@siemens.com>
In-Reply-To: <8d40db3f-a411-46e7-a26e-8be159f6f67d@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|OS3PR01MB8796:EE_
x-ms-office365-filtering-correlation-id: 86bd59b5-2b50-4e41-791c-08dcd1a768e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NnJGMkROS01IWVNhWE1kdXhnN3Bsb3FLVmpvMkkwbWl3RG1iWDRJZVdCYmJP?=
 =?utf-8?B?czNjQ3FmaXlud3BxU2pIYkMwd2xxdFVndzd1RTNKTXBSMVFBa2diZjlMcVRI?=
 =?utf-8?B?SGxjcGpqNkNTSWRlakdnMTV0ZkY4Mk1jSVM0bmhWdUF2cEpZN2NJVHZFcE9F?=
 =?utf-8?B?YlM2dk5CSXRhNm4zamNmS0duR1RxcG9nV1huTFpHdUVVanY2V01XQkNmS0Q4?=
 =?utf-8?B?V0IyVFVsU3lLSmxuWFkrNjNqTXIrN2tMVTlzVlc0UjgzS1VQZDIySGhMSzRP?=
 =?utf-8?B?ZmwzcTZuNmdRY0JFNFhNODVOeWk0aVJlbTVNc0dOTjd1R1VjNHBjZWVTZ29N?=
 =?utf-8?B?SHJSdUoxb1dNMnpaS1dRMG5EbFdZeVd0WlloSFpESmt5ekFONThEK0dMNjQx?=
 =?utf-8?B?RDUyUFdWQTFOYTdmcFlPcFFYWkVCeEdXNW1TK3lsNUwxUEM5b2xoeUhQRkxi?=
 =?utf-8?B?Y1pKNmlvSk1HeXdIZzZudjl5NXlCTXd3WEFtamhMdFp2LzJTeHJPeWRjTFdO?=
 =?utf-8?B?eEpqODZIN0RLeGpoYjJXMHhsRlNtNXhmbFFLS3hlcDNlZ3lGRVdsYnM0bE9Q?=
 =?utf-8?B?enNCZFkzVkVaQXRRSGk1WFBQVEdSemtvWGduRGtyaUlIaU1qZ20yQU4ycm5F?=
 =?utf-8?B?Z2o1K1cwcmFBMldxT0REOHNQdHB0NGlpendYZnlNRzV3UWhEZFpSRnArR0Ur?=
 =?utf-8?B?dElHa1FBdmZ5ZFpDSWtkeVp6Z1F0WGptR3dOZkRIL3RsaTZoSDd1WEQ3eWtk?=
 =?utf-8?B?V2hHVUZEdnR6VTc0NHhxQitVSXBud1hLdGtKWG93eG5URzJoakRiT3VOV29u?=
 =?utf-8?B?ZzA4Y1I2Z05lcUZ0Z2E3cDBmV0FFbmRDMFY0N0Y0ZnFsTW9BK25Zb3pwQ09y?=
 =?utf-8?B?UnBSTC8yY1V5Ti9vbjNGMW53bDhXNTRFWUhITTlCZGVoT01kZU9CSEg4THUr?=
 =?utf-8?B?aDZkd1dZaEVhM3JPWkhwb1pTMGIzTGI5Nk1NZkdMTlVpTXFuYzVqdFVEdVRm?=
 =?utf-8?B?OHVSYVdVa2I4R0JGOE91ZGpvL0xoUmsyVkN6TkE1RjJvNTk2SFZRdGpzN0xK?=
 =?utf-8?B?alp2RndkanRsaUtOQTA4Ukx3NGVoZ0pxN3NmKzczci83dDViVnhIQ3BlOW9T?=
 =?utf-8?B?eC9vUTRiUlIxSTFPK1c3Q3NUbEhpcFpLNkVpTmhoRkwrMU9BNnlORlExWHB1?=
 =?utf-8?B?MXpCUDdBTTNTUWlMaHo4VnphQlh1eDliYUhXSFI0a3BPeFBza1lRQmVkZUJQ?=
 =?utf-8?B?Nm10ajBHZzdyam1KOGpDTE95MlE3QVB5WFBtaFFOb3I2d2FEOFB4TVh4K3BU?=
 =?utf-8?B?SHlnbmVxMDVyNG43amxJWHU0bjJ1dysrMU01N3lQWFFkdEJBRzFSaTV3V1ZW?=
 =?utf-8?B?Q0crMDRYcXVJUDNINFhBalZaak1zQ3FIcjBLbFFjVzA2MGtZM1AzbnZFQ3lI?=
 =?utf-8?B?Q3J1VzMyY2VYeEEvaWNhV3R0aXZxMnNKWW53SUg2U2VTZmFyQVZhRU5lWkRS?=
 =?utf-8?B?bEtJaEpqYVZKek1BMnlsU3NTRXM4Q1Z3TkUxZkg5STE4czRoWkxjUksvRTBF?=
 =?utf-8?B?aGczVG5ZNDBGZG4vOUlyeE14NVdiVGdubDJsRXFpUFRYdDJHK1crenpWN3U4?=
 =?utf-8?B?QXYxQ29OZGRyeHYwTnRFb1gxZWRIdEVEa0w2MzFZWFZoZXNwa3p2OThiWit6?=
 =?utf-8?B?bGlNdjZ4OGJEbzRvaHFQQmViMWhvZHRuVlhmU3VUbS9ndjJUVHZKYURsSGlD?=
 =?utf-8?B?K3dvU2FhSkxOdURHVlU5TXNGNnB5d3JTc2NSZE1sQndpZm8wL3BTVnYvVGM3?=
 =?utf-8?B?TDNsZ1FoaHFzdVltbHpyR1k2eFN3SjdTUDltOHJFRFZJL0NMbjB2THZyK2Jl?=
 =?utf-8?B?Z1h0RHVWaUNkbUJpWUQyUWhiK1lCTjlnckp5OHB0b1d6akE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SXRmcVlpVjVHbGZVQzFsWG1HcWVHVE9veVpZMFdMbzc1blpLTHp5UTVja29Z?=
 =?utf-8?B?TFBhVnU0RDlFWUhUbEU1d2dTTjBCcEdIUkZROGIvdThxVms3UHJidGloVEZ3?=
 =?utf-8?B?U2dHZFhtVW4zYzdCUmZINXluUXN1WCtiendKd0FWRFZvRFZzVlNob3F5UDBW?=
 =?utf-8?B?bjRicjZNY3ZtcmRTOXRscXRCTDdJdDBwNm1BMGJaUDVDVGp2TVNUbEp3Y3lV?=
 =?utf-8?B?Q21JTkdWRDNYcHg0alJFVTdTV2psMWFQc3RjNzhsOXpoalJzbHgzdVc0LzF0?=
 =?utf-8?B?c1VCY0RkeHUyNXA2T2tOUHVmT3NFdnNrUjhRM0Z1d1dUVXVkaFJzYU93NW14?=
 =?utf-8?B?RHhqbURUVlRUcVdlOEpkM3VKK0JEQjM2dkRNOU95Q3RzZTMxSGxsdUh2U1Bv?=
 =?utf-8?B?QVAwMzRxbXJkRlJNaVp6aXh4T3E1TktnWVVCYUZQTkx2ejJJNGd5SnRzaEFM?=
 =?utf-8?B?dWVaZmhSbHJEck80VDYwUmo1c2VjeGlCb2ZlZDRZOFlVNnA0QjYrUlJCbFFv?=
 =?utf-8?B?NkVUSERmNCtzd0VTa2k2TCtFUjdZOFpNTzJoVVpxd2VJZ1p4Sms3SXd2WnZp?=
 =?utf-8?B?Q2E4TFAveW1tY3g0cS9mejhVZjhBTm82VkJ5ckV2ekVLc2cyNENxZHVzYVlF?=
 =?utf-8?B?YjdGRU5odmFETmkvelVlM0FtM3JQaW5RbWlKOEVodlRLbFlKckdWdkhqMmVW?=
 =?utf-8?B?Mll1T2VXUkN6SVJTN0V1aVlPc3FkL0c3bURTcDI2OERsVjZyQWNhZnZTY3Rm?=
 =?utf-8?B?TnFUWlBycEtEUVk0RE9oV285RTNZbmI4azB5UmFWZlNUT3hJbGIrSnlQbHVC?=
 =?utf-8?B?Tk1vWk4xWFRFVVplUDRyY3AwUVc5SVJMR0xmNnVWdWtycy9LYUpJZ0MvcXRj?=
 =?utf-8?B?SXZMTndRc0dxQTBIR0p2VncydXJCbS9vc2x6QVZ6bjVoNko0UkJUNkZyNFEr?=
 =?utf-8?B?R05CcG9qeHduL2JwM2Z1TVpyUE80UjdPUkpEVkRzUW1zM1FuS0pqc1lKMzMy?=
 =?utf-8?B?WlphaXhGcjRRaStWNSt0SGlLUFRPaG9JaExDZ3ovcmFBeEtZQllJR1pVdW44?=
 =?utf-8?B?ZlNHdjluelJyQjdHY1NTR0JaamViRmdVRTNadEFmUEpPd1UzZEthODBMallV?=
 =?utf-8?B?ckJRMG9hYTVjcEhJcWxWMzNhbTM0TFVRYmlNT0JsVjFhbk9vK0JSbmxGUlJH?=
 =?utf-8?B?bG8vbzhuT3JSWXpqZXRaVGxEMDhaQk85eXovdk1yaEpJOVlLNUVhMmhkWVkv?=
 =?utf-8?B?YjR2bXNVMUwxMzRhd01JUjNhZTJ1aHN6NjlxaXZ3dm9KYzRWSzkvOGdNL2lq?=
 =?utf-8?B?aXd6bE42OEowK0F4MUZQS29SVXcxYTRxYjVvMXJXVUExSUp0STRienROUkE0?=
 =?utf-8?B?QVRYbVBtUllycVp3VE9lT0VzWFk2ZGJJdUoxSmNwL21OdExFZG1kUXdDNC8v?=
 =?utf-8?B?U2ZteUo1eFJCZzhwV2ZUL08vQnVpRFNvM0tXaVlzR05Pd0ZqNkJ3RzFPVDR0?=
 =?utf-8?B?T0dPSS9mWmt5REpWQzlabk9PMVpmN2ZXQ2tDdXBCZlRMbWRpejVocE5KcHIv?=
 =?utf-8?B?L2g0RmUyRUQ0TWZrd3R2QVFQc3l3TkZzTUE3OW4vZDJEV2JjT2FTR0NRTndJ?=
 =?utf-8?B?amNmSVUvRDJnVlVuc0ppRE5SbEhjMXFTYTAwUzdhY0lrdXBRUUtPYU1xdWww?=
 =?utf-8?B?SjN0c3VCVkIwTXRZNURwbW1MeVM1T2NLUjhaNDNqZFFWZklzdVJqRXNta3lJ?=
 =?utf-8?B?eG1TWmdTTTdzYTVqdTFNUVBvR01wQVRpaXRSMU1lSkx2WU0raFFtb2ZXYklS?=
 =?utf-8?B?TzMydWgyQjVob2NQS2dQaHIxa2cvWmlnNDh4MFVjWk1FeHpLcWkxdXRuUWQz?=
 =?utf-8?B?MkprL1k3M0NVNzMvNVRyQUVkQnNLYk1lUDZZRUdOb2xEblF5N0VkZGVrMHha?=
 =?utf-8?B?NGdFQmtyZlQxYXFGVnlFR3oxQ3g2K2NuSG1hUTViUUx6UU1OL1VwWjhTOG9Q?=
 =?utf-8?B?aGlSMTF0RDBsR0tydEY4YVFRdlFoZ1JZcjdySzVRLzV2SDIxKzV2MERlRlB5?=
 =?utf-8?B?a1JROTdoRHNPTzN0Y3FzVHV4TXlzUGdkUkxqNzgvVzR1VEpGcytmZGF4Sjdy?=
 =?utf-8?B?VEJZMTZSRkJuczR5WjlVajdKa1h2OXBPZ2FLNVRmL25XYURHQTVKclFpbk9Q?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bd59b5-2b50-4e41-791c-08dcd1a768e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 14:46:52.8480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JW94Z1xK04uR5gVoaEUed3FHAXaAdigOAiXoy5L4eTsH/Nsx5bHZoL32e9sqkSEtQO4vdq4JqI+fwNNX59WzyPnFxWJiAgwODbg7CjrdiEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Sep 2024 14:47:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16879

PiBGcm9tOiBHeWxzdG9yZmYgUXVpcmluIDxxdWlyaW4uZ3lsc3RvcmZmQHNpZW1lbnMuY29tPg0K
PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTAsIDIwMjQgMzoyNyBQTQ0KPiANCj4gSGkgQ2hy
aXMsDQo+IA0KPiANCj4gT24gOS8xMC8yNCAxMDoxMiBBTSwgQ2hyaXMgUGF0ZXJzb24gd3JvdGU6
DQo+ID4gSGVsbG8sDQo+ID4NCj4gPj4gRnJvbTogR3lsc3RvcmZmIFF1aXJpbiA8cXVpcmluLmd5
bHN0b3JmZkBzaWVtZW5zLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDEwLCAy
MDI0IDg6NDkgQU0NCj4gPj4NCj4gPj4gSGVsbG8sDQo+ID4+DQo+ID4+DQo+ID4+IE9uIDkvOS8y
NCAyOjAyIFBNLCBzYWkuc2F0aHVqb2RhIHZpYSBsaXN0cy5jaXAtcHJvamVjdC5vcmcgd3JvdGU6
DQo+ID4+PiBIZWxsbyBKYW4gYW5kIENocmlzLA0KPiA+Pj4NCj4gPj4+IEkgaGF2ZSB0YWtlbiBh
IGxpc3Qgb2YgYWxsIHRoZSBmYWlsZWQgam9icyBpbiBMQVZBIGFmdGVyIGVuYWJsaW5nDQo+IHNl
Y3VyZQ0KPiA+Pj4gYm9vdCwgc29mdHdhcmUgdXBkYXRlIGFuZCBJRUMgdGVzdGluZyBpbiBpc2Fy
LWNpcC1jb3JlLiBUaGUNCj4gaW5jb25zaXN0ZW50DQo+ID4+PiByZXNldCBpc3N1ZXMgZHVyaW5n
IGJvb3QgYW5kIGdldHRpbmcgc3R1Y2sgZHVyaW5nIGVuY3J5cHRpb24gb2YgL2hvbWUNCj4gPj4+
IGFuZCAvdmFyIGFyZSBmb3VuZCBvbmx5IGluICpsYWItY2lwLXNpZW1lbnMtbXVjKi4NCj4gPj4+
DQo+ID4+PiBDdXJyZW50bHkgSSBoYXZlIG5vIGlkZWEgd2hhdCB0aGUgcHJvYmxlbSBpbiB0aGF0
IHdvcmtlciBtaWdodCBiZS4gSQ0KPiA+Pj4gdGhpbmsgdW50aWwgd2Uga25vdyB0aGUgcmVhc29u
IGZvciB0aGlzIGJlaGF2aW9yIGluIGxhYi1jaXAtc2llbWVucy0NCj4gbXVjLA0KPiA+Pj4gbWF5
YmUgd2UgY2FuIHJlbW92ZSDigJhzd3RwbS1qb2Jz4oCZIHRhZyBmcm9tIFFFTVUgZGV2aWNlIGlu
IHRoYXQgd29ya2VyDQo+IHRvDQo+ID4+PiBhdm9pZCBmYWlsdXJlcyBmb3Igbm93IGFuZCBwYXJh
bGxlbGx5IGRlYnVnIHRoZSBwcm9ibGVtLg0KPiA+Pg0KPiA+Pg0KPiA+Pg0KPiA+PiBJIGhhdmUg
dGVzdGVkIG9uIG91ciBydW5uZXIgdGhlIGxhdGVzdCBxZW11IGltYWdlIGFuZCB0aGUgc3d1cGRh
dGUNCj4gPj4gc2NlbmFyaW8uIEFzIG91ciBpbmZyYXN0cnVjdHVyZSBkb2VzIG5vdCBzdXBwb3J0
IGludGVybmV0IGFjY2VzcyBmcm9tIGENCj4gPj4gRGV2aWNlLXVuZGVyLXRlc3QgaSB3b3VsZCBy
ZWNvbW1lbmQgdGhhdCB3ZSBkb24ndCBleGVjdXRlIHN3dHBtLWpvYnMgb24NCj4gPj4gbGFiLWNp
cC1zaWVtZW5zLW11YyBmb3IgdGhlIHRpbWUgYmVpbmcuDQo+ID4NCj4gPiBJJ3ZlIG5vdyByZW1v
dmVkIHRoZSBzd3RwbS1qb2JzIHRhZyBmcm9tIHRoZSBxZW11LWNpcC1zaWVtZW5zLW11Yw0KPiBk
ZXZpY2UuDQo+IA0KPiBJIHRoaW5rIHRoZSB0YWcgICAgICBzdy11cGRhdGUtdGVzdGluZyAgc2hv
dWxkIGFsc28gYmUgcmVtb3ZlZCBmb3IgdGhlDQo+IHRpbWUgYmVpbmcNCg0KRG9uZSENCg==

