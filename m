Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14CD78320
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 13:33:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.172941.1733146405832525086
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 05:33:26 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4B2DXNJk439296; Mon, 2 Dec 2024 22:33:24 +0900
X-Iguazu-Qid: 2rWgWTQ5o3WzeW4qXI
X-Iguazu-QSIG: v=2; s=0; t=1733146403; q=2rWgWTQ5o3WzeW4qXI; m=2JyxiHsYo0QBIJA/D4p2XEVdf/K8/lPjPSXn1niXbp0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 4B2DXMHs3421189
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 22:33:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPMJVQ5hmALMA3rCNfraogsuZi/5WiH9zNOCgP48D0ssRdmcnhmDMWpk7Djd0vs/hq+XznQ3cP3fHCDBI/8XyWGe+q3xzlJe+/4KXNh4VmF1SlqkT/HCBQvT+dSpO7i9uDK+N8teqbqh/u4UpXTqXrgtauoXse4G2md9JyCEtoVRHlPQL3qPeaCpzxmNpLCHs//P415d5/PhoWY1Keq/EvKAhqF9IRmitfv+SEKb7EZtR2To2jKkPyuav/V146gwRCOivLZisEDdhKJOtbzl/gRQwCvVVnXqWQtwHvwjgqcB80i6wX87rlyyr6lw4Jq8gpVt3xbPpftfQPL2nYtrhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ivk+PmDSZ/EEtiiMJlDeg7KLwcl2jDTBc4/TGJ7rY9I=;
 b=SFj6vbgXXhrhtysqNzf/VWon1zcqxidR/jfd5xFJ6QcRwf8TDoZYLOr5p01oz/ZyKrZMc9AOxVOR74rS5lJi/9sYhuZHHSdmftph/gR0HEV70tUNIuApaNcyjN2hgPBRogtFLgaldJdAROfjKq51rfisZRRub4JDyF4MZz959UUv81xUOtg5/zuu0uw3M3IBOAARhj4f6CDy1TgipYmK50NEkS6i5CbvEMznLljr8nEBC5TnoqtTSABF1+YOS0E8wcBn+9Skrr05jOARs2uThPmLlZV/CzEK/Rys/PyoByeKP70oV6jo7eAowWDXMtS+HKogSwr4UQmlHlPJpoNRAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Topic: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA
Thread-Index: AQHbQLwTUaTAYoFsNEu+W9FEgwfyArLLKo2AgAfBa0mAAA2vgIAAAafR
Date: Mon, 2 Dec 2024 13:33:20 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6100597A316A2139498736C6C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103FB47A8576B2CFA3275F6C2282@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <434bc0cc-a0b6-4095-834c-ddd6a3fb2b09@siemens.com>
 <OS0PR01MB6100E150797AAB51AD72A3B9C2352@OS0PR01MB6100.jpnprd01.prod.outlook.com>
 <15dbcfce-757a-46d5-9d08-d4a8298348fb@siemens.com>
In-Reply-To: <15dbcfce-757a-46d5-9d08-d4a8298348fb@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6100:EE_|TYAPR01MB5883:EE_
x-ms-office365-filtering-correlation-id: 4234003f-7c74-4a4c-8628-08dd12d5e355
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?blBNUDF4Q0lVa1dTcGQxcXIrZ3oxU2xIeW1zWk9VNmx1c3k0aExLWXZS?=
 =?iso-2022-jp?B?OG9PNVRSYy9JaXZ0cWlJUUlncEZPUXhvNGtFV1ZENUhzVTFrL0J5aHd3?=
 =?iso-2022-jp?B?MVRCcEpydWtVUVhtcGNiL2dkR08zSWd1anF1akRqS1JGSDNPTGtpZ0VZ?=
 =?iso-2022-jp?B?L01RUjFpY2hIWjJKUituWmluclpiQXNNWEtObDI0M1pkbUNRMFZMZjQr?=
 =?iso-2022-jp?B?NkVQSXVYd1FXZnZHQ1Q3SW81a09JcmhER25JTStVcWE3eGJiN3VoWENR?=
 =?iso-2022-jp?B?M1dxUGc2MHE4dzRyU0VzWG9DbkJEallmTGYxREg1SkkrNUMzb1BaZ3NI?=
 =?iso-2022-jp?B?eWlmdVJpSmlKTHVyTXU2TmZGQ1RxUnJVQSt0TFlYeGpUemc4RTMxc1hk?=
 =?iso-2022-jp?B?eW1ZeldRQ2JWQzVXYzgyRVFycVk4SEZWZ0k4WWo1bnNHM25Ga0h6YVZN?=
 =?iso-2022-jp?B?NURmckQ2L296RkdiT0lBZlN4UTN5ZFVXcnpKYnhkQVNwZmE3YkR0NU15?=
 =?iso-2022-jp?B?a0phYXpjeFBXb0RKRVNJODZsTTZ2VGJ0Vk12b0FWWTBQdExLUUVVK3V1?=
 =?iso-2022-jp?B?M3k4V1M3VWNzZ0twcm9ReXlQSUtDMTdJN1RRb0RuSnlmNzhpMm1RK3Q5?=
 =?iso-2022-jp?B?MW9NNUpNWnpBbjZrclhDa2d0LzV1ZEEzZTZXbGRiek5CM0FNQ0dLVHQv?=
 =?iso-2022-jp?B?MHZONjJGZFVBeDV4S0pZV0JXNjgveUZ5U1hyTzIydXRBUVBkRU9hZExh?=
 =?iso-2022-jp?B?Ry9VVG5wL0FuWEtLR1lWWUdjWVhlbHBUTnZja3V4NVFlNWwxUDZZUDlm?=
 =?iso-2022-jp?B?QllGZ0xabTJNTUtTK25BeUNvL2ZDSW8zQ1FtWjdSMW1CUy9VYnpsejM3?=
 =?iso-2022-jp?B?NFV5cGxrNFdGWHRKUFhJcEQwRFhYYzc5QlIxWFdvdWxoVVhVZTF0dXk1?=
 =?iso-2022-jp?B?UEJLSWdtRHh1aS9rcCtIUkJoK1JDaGM4SXJORFBlOXEwY2JiMk1IZUxp?=
 =?iso-2022-jp?B?YVl4bXlLZTlRRG5xSkpTcWFNdzV1WVI0dFQ5T3l1VWg4QWMwZXVXbTVO?=
 =?iso-2022-jp?B?T3AxNFR6QmhyVXhrbTVpQU1sZUJFc3U1OC9jSG1SOXpuRTdoQmQ5QmVx?=
 =?iso-2022-jp?B?M1ExaWJ3cFRuM3FKRU5iNFhRbE5jai9INnU5eGZMSjlsYVd5aDIvdTZl?=
 =?iso-2022-jp?B?NlhKZHpoTUVuVlh2dDBXY0Jia1N2R1NOVDEyY1hmbUVOb0JzWmdMSGJn?=
 =?iso-2022-jp?B?L0lySVBzYnlsZDBXMy9kUDBxQkxhaExyOGZrOW1ncWJ3UmdVNWh4ODg4?=
 =?iso-2022-jp?B?Q3NyNU9vUGpVTDdFeGtVbUlTRnl1ZHRhYVAra2hBR2wrdnJCdlU2SWNq?=
 =?iso-2022-jp?B?TDluMWpJWGhXbWg5R2c3bmVNMTRRNmZkZ2tNNVpUZ2Jlc2JHQ3JXaGQx?=
 =?iso-2022-jp?B?QllQTGJWbm1Gd3JvdytWQmFHRUdIV2dyazRxVW4xMzVmaWhhMXNMMGJG?=
 =?iso-2022-jp?B?aFAvTUVQVlRWcE1DckNYd3BjU0c3Rkw0akRabUl1MmFrZlFkRUFVUUg0?=
 =?iso-2022-jp?B?M1RRbXhXUHRiVE9XQk5DOXBUbnlhNzlveUxoYS9OY3hYQU1naklKY3hV?=
 =?iso-2022-jp?B?QjNYZ0VTMEhUdnhOUytsUTcyVE1tRU9TYjd6OUFzQllQMXUrcm9WVlU2?=
 =?iso-2022-jp?B?ekE0OUJQeVRQaWJuM3ZGa0Jzai9jRTJJR3RaWExKQXhjeW01OFZrRmd6?=
 =?iso-2022-jp?B?b0VyaHRlQ05aTUhFZlNHUDB1UDg0UG9HZ3Jsc0JuN29LSkRnTG1TcERB?=
 =?iso-2022-jp?B?L1VvSEFwQkw2YUd6RHVQQUNjWXJXUlovMUpwK3oyNGxtVGlCRVJNSUY1?=
 =?iso-2022-jp?B?dFZnWDNPOUJHWDVTQWJuU3prTkR2MFphY2J4dXIvTDRQNVBxaFd2N2lv?=
 =?iso-2022-jp?B?ZExzbEwxOEN6SFU4QlZlSTUzaGlqam96RzIxck1helN4OVRGVEs4aXor?=
 =?iso-2022-jp?B?blNJNGw3Y1drZUVKVkVxTkR2ZFJYczJieDVPb2N1aHpJNFVjdGhFVGFv?=
 =?iso-2022-jp?B?Zmc9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6100.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?S2hTZXJvZHYvTG5MN2dQNnE0eXJkanJrbzVhNTh4WngweVhOUmw1OUtQ?=
 =?iso-2022-jp?B?enlWSCtpMXZtTms3V1UzSWV0YkhoZ25JZ3lmbis3dUR5UE1pOHcyQ1JL?=
 =?iso-2022-jp?B?WHh6UktMR3h3REtmblgyOXBTYlFRaUdFVEFWUm5zU213YnpUWmw2cENL?=
 =?iso-2022-jp?B?OThlMjZ3UDBvNnVZU0FMS1pHcDdTbk0ybmgrcFk4OE9QT0lRS0dkR0h4?=
 =?iso-2022-jp?B?VUJWbzlUay9vamtwaDlIMFN2SVU2cExhcWNtU3BHTDU5WXJKdjFBNGlh?=
 =?iso-2022-jp?B?eHNlOG44UEdDdGtwS2JYNGp3dWhBYlpnNjZrc2RXSm0yV2lZRkpGSFNs?=
 =?iso-2022-jp?B?Y1g0YkZlY3diS3BaQVEvK1Q0SnhreDNzaXEzOW56VGdWYXZDU3Z5ZXgx?=
 =?iso-2022-jp?B?NnRIcGVneHd2Tmoxc1FndXczaFFTbXRNR3J0NjhTaUwzSTloc0ErN3NF?=
 =?iso-2022-jp?B?ek5VTkxxUW5sc29vUzR3emRZOXMwVmVzSFRtN3ZJSW5Xa1RjSmk0TWI2?=
 =?iso-2022-jp?B?eFA0elJhUVF0TVFiVVVmVnRycVBoRkhlMy9XWGw3bzV3VGZBVDNDSjda?=
 =?iso-2022-jp?B?Ulg2bmwzanFUZkwvWUtrQzNIbE9ybjFjUmo0KzFhWmpqQitUUGI5aFBl?=
 =?iso-2022-jp?B?alpqUndMOW1LV2RXZWViaWZsSithVkF6RXZ6emdBYm9Ld25lT0JQYU1M?=
 =?iso-2022-jp?B?RC9wREx3enNqcEhnOHNBSHQ5RCtyRnlkUWZKQXplYkkzM0FFSzl3bE1T?=
 =?iso-2022-jp?B?N05FTFdsQm54eEtMTEpBcWdCM3BKbENDcHhOQXFaZVV1WVRvd2c1QjJJ?=
 =?iso-2022-jp?B?VFhKbnVxT2QzZ1piV1UvSDI3d2NTQmRtT1MvNmdldmd4bTV5Z21HdC9l?=
 =?iso-2022-jp?B?Y1B5M24xc3pGN1hTOVZhL2tvcENjUHBGWHliUTR2TEdRZGZPVUJCTGdO?=
 =?iso-2022-jp?B?N0loQnh2ZkVua0t5UFVPQ2RpdnVRc0ViU0FxQS9wRG5SUzh6aG5pNVpZ?=
 =?iso-2022-jp?B?bEg5eCt6c2xvT3kwSDcwNTN0a1hQOUZlcmovRmMwTWZGeTVnc0hGbHI1?=
 =?iso-2022-jp?B?eUFRb0pBTURIRmNFVkZrTEx1eHhNdGIvMTdUV2FBcUJkQkIycVgvcHJi?=
 =?iso-2022-jp?B?RDVidFJrWEV0MW5GbmdHVEVqZjlxWStsNGhGSTV3OWRVaFN4aHhvSG1J?=
 =?iso-2022-jp?B?VHhkQm5OMnNJRXREV3duVEFIa3g2aG4vUnpvVE5Qd05rekJpaHo5WUla?=
 =?iso-2022-jp?B?THl5T2dkWUYvWUMwMVQ0ZlVhL1VZL0F2TGFZVlN5ckV0RmtkeUVCdndB?=
 =?iso-2022-jp?B?bHJ3ZmNCOUorOXZoNzlTZHhYQndwQ1dPMUVJdzI5bkx2bExzNmQ3S1ZP?=
 =?iso-2022-jp?B?UW53STd2aWhYQmROY2MrTDYvQmMwUDRjWkFNem4rdFhCbDVMK0x0UkxW?=
 =?iso-2022-jp?B?eTBwajkxeUhnMGJidmtMTFR4V1draGpvMzBkWkY2ME0xZmJQTjNncmcy?=
 =?iso-2022-jp?B?eVJ3empRVS9MelpKQkFZWkZrTjlLZWpackJ6d1RQVTBNVWUrZTU1MUov?=
 =?iso-2022-jp?B?dHk0UHBiR0ljeUFReWQ0YmNvaUF0aFpGL1B5OEFyZ1BYTmczR01LdmRI?=
 =?iso-2022-jp?B?MUFoVjZiV20wR3hPNHovQjlCQ01yOGdWR2U5OUM1eE93WGo0UGZwUlRI?=
 =?iso-2022-jp?B?QUgxdnpqQ01xcTZKb254UHJ1RmlkY0lYTW1vSjFPNzBwSkdTRXdvZm5S?=
 =?iso-2022-jp?B?SmJoM1BrV29PZDhyRUdka1R0OFplNE9OS3dQMzVGeEJuaVZJYUpCWVVB?=
 =?iso-2022-jp?B?eGRQSndUWTYybXJPN1pobC9LSUNCNFI2cDh4TVpneWMyWUJ1anpwbGZv?=
 =?iso-2022-jp?B?UjB4R050ci9GOUQxNEhDVG11K284dXQ5NG9PcFZCdFl4ZjN6cGtJL291?=
 =?iso-2022-jp?B?MTZmdHZ5M0hWdkxpb2JKNENPaDVKbWpRLzdPbS84VGdvYTh0OXFkWnN6?=
 =?iso-2022-jp?B?dllBWXQ2QU4va0VBYWNnNGNRSUp2NGcrZy93dFpkMVRUc2I1bG81QkJu?=
 =?iso-2022-jp?B?M0Y4M0p2VEhFd2NVUlI2K2ZIK1kzSnVWQytHM1dacDhXYmlOWE94bytX?=
 =?iso-2022-jp?B?elU4VENnSzZTUjNja1lFU0doSkxmdVd3NjJWUXRBSHV0NXVlTkhUQk1u?=
 =?iso-2022-jp?B?anBQWFQxSDRxUE00NUcrWmtSZFZ3L0h3Y2ZOaW03QnNLeVgrbThQTllJ?=
 =?iso-2022-jp?B?MDh1U3h6aktvbzdJOFVyNDNqU1BNa0VsOU1OdUFYTzlHOERWT3cwQUxq?=
 =?iso-2022-jp?B?RS9FRTBGbHYzckM3UHkvdUN1eU10Sm8wRXpIOEdHWWc1THZxYy9ieVd4?=
 =?iso-2022-jp?B?cmU4bmQ4RUhYLzlHdjFZcENrTzJsbFNHOWl3ME1XRDVMaktEalNPemNa?=
 =?iso-2022-jp?B?T3BiMWVBPT0=?=
Content-Type: multipart/alternative;
	boundary="_000_OS0PR01MB6100597A316A2139498736C6C2352OS0PR01MB6100jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6100.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4234003f-7c74-4a4c-8628-08dd12d5e355
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 13:33:20.7474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Llej5/ub83LlZX60+g3EfqK48fENYGkF9Ykpy2boa2Tdzc7GD67drg+fEH6ijeNug6tyG2IaNhdYUYzer7bd+o2cd4OthMcCpmkF9NhFHCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 13:33:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17307

--_000_OS0PR01MB6100597A316A2139498736C6C2352OS0PR01MB6100jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi Quirin,

Currently we have only one test case where we verify the secure boot enable=
d message in the boot logs.

Regards,
Sai Ashrith

________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Quirin Gylstorff via lists.cip-project.org <quirin.gylstorff=3Dsiemen=
s.com@lists.cip-project.org>
Sent: Monday, December 2, 2024 6:54 PM
To: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; Chris.Pa=
terson2@renesas.com <Chris.Paterson2@renesas.com>
Cc: hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D=
#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LAVA



On 12/2/24 14:09, sai.sathujoda via lists.cip-project.org wrote:
> Hello Quirin,
>
> Thanks for your help. We will go through https://github.com/siemens/mtda
> <https://github.com/siemens/mtda> to understand how this can be used
> with LAVA to flash and boot the WIC image.
>
> As you said, the secure boot image can be booted on a device with
> "Secure boot disabled" in the BIOS but we have a requirement to automate
> secure boot testing as well, so we need to figure out if there is a way
> to configure BIOS through LAVA before booting the image.
>
>   If there were multiple devices, then this could have been handled
> using tags where security image related testing can be directed to a
> certain device with all secure boot related pre-configurations done in
> BIOS where as the non-secure images testing can be done on the other devi=
ce.
>
How many test case really require secure-boot enabled? Most test case
should be written in a way that the don't require secure-boot enabled.

Quirin

> We can start a discussion thread in lava-users mailing list to check the
> possibility to implement this.
>
> Thanks and regards,
> Sai Ashrith
>
>
>
> ------------------------------------------------------------------------
> *From:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on
> behalf of Quirin Gylstorff via lists.cip-project.org
> <quirin.gylstorff=3Dsiemens.com@lists.cip-project.org>
> *Sent:* Wednesday, November 27, 2024 7:39 PM
> *To:* cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>;
> Chris.Paterson2@renesas.com <Chris.Paterson2@renesas.com>
> *Cc:* hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in LA=
VA
>
>
> On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:
>> Hello Chris,
>>
>> We are planning to run software update, secure boot verification and IEC
>> layer tests on M-COM x86 device in CIP LAVA.  To achieve this we believe
>> there are two main challenges.
>>
>> *Booting a disk image (.wic) on M-COM x86 in LAVA*
>>
>> We went through the existing job definitions running on CIP reference
>> hardware on LAVA to re-use if any disk image is being booted on them but
>> did not find any. In every job definition, the root file system tarball
>> and kernel image are deployed separately to tftp. We are going through
>> LAVA documentation to figure out proper method to boot   entire disk
>> images on LAVA.
>>
>> Can you please provide your suggestions on how to do this, if you have a=
ny ?
>> Once we are able to boot a disk image, then next task is to boot a
>> security image.
>>
>
>
> I would suggest that you check out https://github.com/siemens/mtda
> <https://github.com/siemens/mtda>. This
> provides
>    the necessary tools to flash a device over USB/SD.
>
> We would need to adjust the lab setup for this.
>
>> *Configuration of BIOS settings on the device's firmware to boot a
>> security image*
>> *
>> *
>> Basically, CIP security image has secure boot feature enabled, so before
>> booting such image there are some settings that need to be done in BIOS
>> such as:
>>
>>  1.
>>     Enabling secure boot option
>>  2.
>>     Adding secure boot keys in EFI storage.
>>
>> Only after these steps, a security image can be booted on M-COM x86
>> hardware. I am mentioning these steps based on our current experience
>> with local setup. But I am not sure how to achieve this on LAVA.
>
> You don't need to enable secure boot for testing - an image with secure
> boot will also boot on a device which has secure boot disabled as the
> image does not check the state of secure boot.
>
> Best regards
>
> Quirin
>
>> One idea is to pre-configure the above-mentioned settings in the device
>> present in *lab-cip-siemens-prag *but in that case I believe health-
>> checks and all other tests running on M-COM x86 can boot only secure
>> images.
>>
>> Is there a way to change the bios settings through some arguments in the
>> LAVA job definition ? If not, then can you please provide your opinion
>> on the above-mentioned approach.
>>
>> Thanks and regards,
>> Sai Ashrith (T S I P)
>>
>>
>>
>>
>>
>>
>>
>
>
>
>
>


--_000_OS0PR01MB6100597A316A2139498736C6C2352OS0PR01MB6100jpnp_
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
Hi Quirin,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Currently we have only one test case where we verify the secure boot enable=
d message in the boot logs.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards,</div>
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
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Quirin Gylstorf=
f via lists.cip-project.org &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-pr=
oject.org&gt;<br>
<b>Sent:</b> Monday, December 2, 2024 6:54 PM<br>
<b>To:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;=
<br>
<b>Subject:</b> Re: [cip-dev] Booting security image (.wic) on M-COM x86 in=
 LAVA</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 12/2/24 14:09, sai.sathujoda via lists.cip-project.org wrote:<br>
&gt; Hello Quirin,<br>
&gt; <br>
&gt; Thanks for your help. We will go through <a href=3D"https://github.com=
/siemens/mtda" data-auth=3D"NotApplicable">
https://github.com/siemens/mtda</a> <br>
&gt; &lt;<a href=3D"https://github.com/siemens/mtda" data-auth=3D"NotApplic=
able">https://github.com/siemens/mtda</a>&gt;&nbsp;to understand how this c=
an be used
<br>
&gt; with LAVA to flash and boot the WIC image.<br>
&gt; <br>
&gt; As you said, the secure boot image can be booted on a device with <br>
&gt; &quot;Secure boot disabled&quot; in the BIOS but we have a requirement=
 to automate <br>
&gt; secure boot testing as well, so we need to figure out if there is a wa=
y <br>
&gt; to configure BIOS through LAVA before booting the image.<br>
&gt; <br>
&gt;&nbsp; &nbsp;If there were multiple devices, then this could have been =
handled <br>
&gt; using tags where security image related testing can be directed to a <=
br>
&gt; certain device with all secure boot related pre-configurations done in=
 <br>
&gt; BIOS where as the non-secure images testing can be done on the other d=
evice.<br>
&gt; <br>
How many test case really require secure-boot enabled? Most test case <br>
should be written in a way that the don't require secure-boot enabled.<br>
<br>
Quirin<br>
<br>
&gt; We can start a discussion thread in lava-users mailing list to check t=
he <br>
&gt; possibility to implement this.<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt; *From:* cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.or=
g&gt; on <br>
&gt; behalf of Quirin Gylstorff via lists.cip-project.org <br>
&gt; &lt;quirin.gylstorff=3Dsiemens.com@lists.cip-project.org&gt;<br>
&gt; *Sent:* Wednesday, November 27, 2024 7:39 PM<br>
&gt; *To:* cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; <br>
&gt; Chris.Paterson2@renesas.com &lt;Chris.Paterson2@renesas.com&gt;<br>
&gt; *Cc:* hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <br>
&gt; &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
&gt; *Subject:* Re: [cip-dev] Booting security image (.wic) on M-COM x86 in=
 LAVA<br>
&gt; <br>
&gt; <br>
&gt; On 11/27/24 12:07, sai.sathujoda via lists.cip-project.org wrote:<br>
&gt;&gt; Hello Chris,<br>
&gt;&gt; <br>
&gt;&gt; We are planning to run software update, secure boot verification a=
nd IEC <br>
&gt;&gt; layer tests on M-COM x86 device in CIP LAVA.&nbsp; To achieve this=
 we believe <br>
&gt;&gt; there are two main challenges.<br>
&gt;&gt; <br>
&gt;&gt; *Booting a disk image (.wic) on M-COM x86 in LAVA*<br>
&gt;&gt; <br>
&gt;&gt; We went through the existing job definitions running on CIP refere=
nce <br>
&gt;&gt; hardware on LAVA to re-use if any disk image is being booted on th=
em but <br>
&gt;&gt; did not find any. In every job definition, the root file system ta=
rball <br>
&gt;&gt; and kernel image are deployed separately to tftp. We are going thr=
ough <br>
&gt;&gt; LAVA documentation to figure out proper method to boot&nbsp; &nbsp=
;entire disk <br>
&gt;&gt; images on LAVA.<br>
&gt;&gt; <br>
&gt;&gt; Can you please provide your suggestions on how to do this, if you =
have any ?<br>
&gt;&gt; Once we are able to boot a disk image, then next task is to boot a=
 <br>
&gt;&gt; security image.<br>
&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; I would suggest that you check out <a href=3D"https://github.com/sieme=
ns/mtda" data-auth=3D"NotApplicable">
https://github.com/siemens/mtda</a> <br>
&gt; &lt;<a href=3D"https://github.com/siemens/mtda" data-auth=3D"NotApplic=
able">https://github.com/siemens/mtda</a>&gt;. This<br>
&gt; provides<br>
&gt;&nbsp; &nbsp; the necessary tools to flash a device over USB/SD.<br>
&gt; <br>
&gt; We would need to adjust the lab setup for this.<br>
&gt; <br>
&gt;&gt; *Configuration of BIOS settings on the device's firmware to boot a=
 <br>
&gt;&gt; security image*<br>
&gt;&gt; *<br>
&gt;&gt; *<br>
&gt;&gt; Basically, CIP security image has secure boot feature enabled, so =
before <br>
&gt;&gt; booting such image there are some settings that need to be done in=
 BIOS <br>
&gt;&gt; such as:<br>
&gt;&gt; <br>
&gt;&gt;&nbsp; 1.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Enabling secure boot option<br>
&gt;&gt;&nbsp; 2.<br>
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp; Adding secure boot keys in EFI storage.<br=
>
&gt;&gt; <br>
&gt;&gt; Only after these steps, a security image can be booted on M-COM x8=
6 <br>
&gt;&gt; hardware. I am mentioning these steps based on our current experie=
nce <br>
&gt;&gt; with local setup. But I am not sure how to achieve this on LAVA.<b=
r>
&gt; <br>
&gt; You don't need to enable secure boot for testing - an image with secur=
e<br>
&gt; boot will also boot on a device which has secure boot disabled as the<=
br>
&gt; image does not check the state of secure boot.<br>
&gt; <br>
&gt; Best regards<br>
&gt; <br>
&gt; Quirin<br>
&gt; <br>
&gt;&gt; One idea is to pre-configure the above-mentioned settings in the d=
evice <br>
&gt;&gt; present in *lab-cip-siemens-prag *but in that case I believe healt=
h- <br>
&gt;&gt; checks and all other tests running on M-COM x86 can boot only secu=
re <br>
&gt;&gt; images.<br>
&gt;&gt; <br>
&gt;&gt; Is there a way to change the bios settings through some arguments =
in the <br>
&gt;&gt; LAVA job definition ? If not, then can you please provide your opi=
nion <br>
&gt;&gt; on the above-mentioned approach.<br>
&gt;&gt; <br>
&gt;&gt; Thanks and regards,<br>
&gt;&gt; Sai Ashrith (T S I P)<br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt;&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_OS0PR01MB6100597A316A2139498736C6C2352OS0PR01MB6100jpnp_--


