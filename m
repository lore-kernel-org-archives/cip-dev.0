Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3EFC3ABAA
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 18:30:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.57774.1746469823652560960
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 May 2025 11:30:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 545IUEn61859608; Tue, 6 May 2025 03:30:14 +0900
X-Iguazu-Qid: 2yAbJ3LJ4FyyBojeXC
X-Iguazu-QSIG: v=2; s=0; t=1746469814; q=2yAbJ3LJ4FyyBojeXC; m=EjNOqMOVJZM49TO7AbvWGaRopdet1Xm4A3crzTLWAEA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 545IUCK51325653
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 03:30:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsdGAIvWST27YIKjM86N5tIeLZzF1wCil1UfFss9JnHiJJDauDiCwob3yXnkBki86tUl7JMooItghmDtiaQ2BtHbm5R144KuAdEDeFTTB49+McyFvb8F1sBI1UMQ+e43AIw6WHP8K9cNy+G1m4osLqdiXuBLTwKT/EAtvGATCB9NmDS66I4/vHoPdIE5xQmipBjqLJGYI1WsuZJfa1LD4GiyBsIQciisn8DoZKH4RK6ErxiVUnVzen5I3IC+BRqiwGSSFqVWLBvJaYRcWCv9otTxY3+JeWPQFYf0tarJGnyMlLkGdzlBmK6j5/FBZ3mxsp/rHu2o78GNKafrqeDidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tGB1vmUpYpB1j+4qmq2b9+wZdl+p0C8Zt3GJQzomwU=;
 b=Rx6SedZJj+UfAX5vDwZJ3iQJz4eoxiF80ItCDBxv/vRb6j3KcS/NH7xF4mgrLrSSIfaCoVMcT+geplKBqq5+4aXe/spvKf9G13qpKzlnJMbK+186DsFU2QwCyyoNc9GlD/j24Y55lVlsDQ7E5Oh10J0Uz5a8BcXPSLtQCyqnjMVPm9ktUhtumFj7EbWQFOC/8rqwmqWOAtDNraxepFXcTXzZUS3sUqhHCikEhXjr0FamKS/f69Sys922MktXuXGu/gIF1l/YNc1LSjVHzJsQmEA6R6r9yXYyhCLyqbklxssbhrUE9RqEz/YhxhB+a3CIZGBvQaxdLZZcgKVmHHoSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <1103432@bugs.debian.org>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
Subject: Bug report for aide
Thread-Topic: Bug report for aide
Thread-Index: AQHbvel4kMHuRxD4wUi3GsU3MPs7kw==
Date: Mon, 5 May 2025 18:30:09 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSCPR01MB14838A7EC23773AD5E01E9410C28E2@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSCPR01MB14838:EE_|OSCPR01MB13734:EE_
x-ms-office365-filtering-correlation-id: f2d92726-cc77-41ec-cdb1-08dd8c02ddec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bHJNZThwWU5EbDBiUUVJTndLWVRuL0hkL2J3cW9VNEhMUVB1OFk3WWVi?=
 =?iso-2022-jp?B?QlpIbHpzaG1BK2xqOE94eWFudTNQUTZVRmI1Rjl1T1RXZjVmazRCVVds?=
 =?iso-2022-jp?B?dUprbmpGVHV2ZnMvd0NvQ05OZVBtenE1NGJESW44bTdXSnRFK1hXK1c5?=
 =?iso-2022-jp?B?MWN6S0xWa3pjbUZpZXQrcGlEMzU1alluRGZwN05yZVlyenljSVgrR0g1?=
 =?iso-2022-jp?B?WFRsaHJiYUJWbHpsZFdrUTJWdlpPM0cvNlBYaytHOGFTdUJ2eFE0RjF4?=
 =?iso-2022-jp?B?ekJIOUR5ZSt5V2N3T1VTbDNGQ3NnaC9KeUhkYzZ2bGpHK1llNE1oVzhq?=
 =?iso-2022-jp?B?Myt4TnVXL1V0eE9MQ0xYOTltYVFzMTlaZ3ZwS1YzYjJFVFNiMGRROWFv?=
 =?iso-2022-jp?B?OGs5bGU1OS9FMlB0eE51OTBQaHRjWmhQVlhrRFVzR04zeDVXNFAyRjFO?=
 =?iso-2022-jp?B?V2tHZGJ3eE9JY3pnbHROWEF4QmtIYUpTVURudEJGMHZsUUhlUUlkTTIz?=
 =?iso-2022-jp?B?TDNmOXNnQ3FCQlpGVnF0Zk52N1ExSFNTK21HUzJHRWN1VHk4MUR6eTF1?=
 =?iso-2022-jp?B?ZTBQK1lHMStjdFAyZFBzeXF3UFVVM3NQMkhoUlcxNkFxRmpobVVjR0Ez?=
 =?iso-2022-jp?B?Ui9jV0RKU2d4MUplK2VOamYvNlBXQ21sa1poWEQ4SUt0RytuUEF6S1A4?=
 =?iso-2022-jp?B?MmdvMElzdE85dkZsSWlTMUtITUdEV3NlL0xYSlJQQmZ2WEQrM0dGbi8v?=
 =?iso-2022-jp?B?Nis5ckswVVNXODhkb3Z5TDNDM0gwYWxGL3M2NzNpSis0TTg3RDBXRlNn?=
 =?iso-2022-jp?B?VGczdytsVXp1bUFkU1ZPWng0NUNkUitpcGpmcDNscFJJWkU3MGJsVS8v?=
 =?iso-2022-jp?B?Nmp5dWdrNlVYNWVGM2VBUmVxRjVnZ3U0S0ljK2VmemRUbjNoT1RRNysw?=
 =?iso-2022-jp?B?UUVFUHRwNDRwaVo1Q1R5OS9Gd2kveVRpaFFUZSs1WnhIeUNnL2RlS1dD?=
 =?iso-2022-jp?B?YVpYM1owenVLdDFMWVJramZQQmFsOGhITFUyYkV3MHN6elkzRngydTJy?=
 =?iso-2022-jp?B?MndXZGtqTGN3R3pNalYxVWszNXdha3FXVGRXc1M3K2ljQUEzazAzT3d6?=
 =?iso-2022-jp?B?eU52WEM2YmE5QVNCK3lNNTlhNmJZblNhczd1Z0xFTk42VDYxNTAzVWhX?=
 =?iso-2022-jp?B?TG8yVmtwYTV6VkpCTmxpdUlRVDZJZWcvdkQ1SFoyZElvbXVpcGQ3K3NM?=
 =?iso-2022-jp?B?OG9jRmNmMjBnK0RUdDkzY3JXWFZvWUdJSFFDNkR1VkYrSVVxVDZWUTFU?=
 =?iso-2022-jp?B?V1Qrc1c4RUc5NWNQdmJHZGlQQ0U3ajdablI0TnFMTmtyTEQ5L3NpaFlQ?=
 =?iso-2022-jp?B?dGlVVUhxcEN3YklFSHNJdWtPWDBoK3NuVzhWN3ZaNktTOE5xVGJva2M0?=
 =?iso-2022-jp?B?bGdwTWdkREo2R3RjbkFnd1ZPUURsRDhaMEFMYURNM09Ta2VmejVJY2xP?=
 =?iso-2022-jp?B?RllYSnhNNHpoaXB3NEM1SHRrc3NuZkNXVkRWUEJLK1R2NEF0Y2VsZS9S?=
 =?iso-2022-jp?B?c2JnMVFhWlByTnpDMk5ZL24vZWdvZEVMRGlXbnN3cXVwOTFBNy9rdzYr?=
 =?iso-2022-jp?B?UVRaUGdiMWhEVUlRUkRGc2pEUkEvd2ZnTTBNQkV0R1JsWFpDNy9CMU9W?=
 =?iso-2022-jp?B?SlNjU1hiU0tVbytJdmxVRHNRUUlXaTBPU0pzeER0VVJudHlUM1RIV2pz?=
 =?iso-2022-jp?B?SkJsMXBsUy9Ia1U5aDhEdkttKzJvNmxIVHREa1JzWTcrNVl3bGFXdlRo?=
 =?iso-2022-jp?B?cDNOSkxnbDBuOTkzQklJZmVKczRUc3BmaDgxUjVtRGVydVJhMHAzNWJZ?=
 =?iso-2022-jp?B?eWJ4TXdpNzlmRFRlUDNmd2tDZkZ0ZDlsb05PdHpBajdiaytxSG42T2Q0?=
 =?iso-2022-jp?B?Ny8rSXJnbHRKNVhIZCtPZWhHV0paZG9xRWl6eTVJWGppVFFQUW92M3hE?=
 =?iso-2022-jp?B?ZTV2N3Fienp4SVJlNkp4Z0VjT09DUm5NWCtEVUhpR045STY4T0tCcFFR?=
 =?iso-2022-jp?B?QzcrQWpnc3hFYjZibnB3MTk0TDVobmwwanAzVmJyS0hCQXNlQXBnMmxK?=
 =?iso-2022-jp?B?NWNXZEdKNkZuSkNIQ25NTmZId3FOQkZHSGhQQU40UGV2VE1HZ29tNUJB?=
 =?iso-2022-jp?B?Ykk0PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSCPR01MB14838.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UGV2Y0NHS1k1OEVzM2VrNVNTUys3aWNNMDdYL3AxQy9LUEdwK3NBME0w?=
 =?iso-2022-jp?B?b3VPNDQrL2FwZmhlWVU3NzBWdnF3WmI1QXRDUGk4eDdlaGhET0ZSSnpY?=
 =?iso-2022-jp?B?ZGZQbXpkZ0NjZkZhT0hKTXhYOGhUWUl1UXNCbmNFbmZlZlplUWQyVTBU?=
 =?iso-2022-jp?B?VnMrOUU3bERHeXdQSkxETXdNSmt1TlpHbmNIaTVQTDNveVl1citTYm95?=
 =?iso-2022-jp?B?QjUyQm56RWh6eFRnVGVZdy9hYXo3dTRpRktCMEk0MmZxaG9ENjVORml1?=
 =?iso-2022-jp?B?OCtqdVhGS3AwMVBwTC9iSkRtV1JDbnBDZFRtOVBVVEI3ZDIwMzBGc1U0?=
 =?iso-2022-jp?B?Ly9HQm1BcmlES2tOdWdLeEh5N0hpT2llTGZOMUFsdEpLVlpQdnlYQ2FG?=
 =?iso-2022-jp?B?azZYNDdGcFlZblppWnFTTXFVYkpRaWFjRWNUNFBqWWs0NjNaK2tiTTVm?=
 =?iso-2022-jp?B?UjQ3N3R0V1p1Mjk5UWFBaWFUbmdsOUhjM2VmbXpvWDNwNEw0c2NXTnNC?=
 =?iso-2022-jp?B?c3I1c2dlL1hnNlRxQndlWkkyem11bmJ3bVVKWnZzNTRYSTZVV3R5Y3JJ?=
 =?iso-2022-jp?B?L2xBbnNKaUFsMnc5Sm54bWFqaklHbDVZV0JQSU5uUGhJaUYxOEI1SkZy?=
 =?iso-2022-jp?B?SElyNnd6UytKOHJzQ1N3eW5hcE5CbktnR1dpNW1PY3J6R2lUSnFkc3BF?=
 =?iso-2022-jp?B?aGhoS2EvMjRCRXZidkFQQ0hPbXJaZUdIclpmUDB0ZGZrc1l2ZlEycjNU?=
 =?iso-2022-jp?B?ZWdiaTdsWGNBYy9URGJXMEZTZE5HaFdITkJBSWx0TE51VTRUbEpyY1FG?=
 =?iso-2022-jp?B?ZlBqUFlkMmxiZmJKMTNYWFMybW10QTBwODlaQUp5NDh5T3VlaGxYTjN0?=
 =?iso-2022-jp?B?ei83Kzh3aHNDSkhhRmtOUzJ3aGdBdnFCdWtlWDFlQTd0RUdIc1VCNkhS?=
 =?iso-2022-jp?B?a3hCblVNZlZyQktQbGc4SGZUTUpzTmZNc0lPMzV4UmhrZ1Q0M2l2N00v?=
 =?iso-2022-jp?B?SklFditpODNWbENSb3pJdVFLZHkzVkw0N0ZGV3htblQ5MUlHY1VwTzFl?=
 =?iso-2022-jp?B?UnhPQzlKaHdDcWhQbi94YytnQ3ZvQ3doYlJLSkNlTXRLRzBzOGdQS3pF?=
 =?iso-2022-jp?B?Qk9KZDE2Mm5hWDc3UXFYeFVqZUVQODZ6b2cyYS8vRDRjamJydjFPdWw0?=
 =?iso-2022-jp?B?UU9lekV6Zk93ZDM5Z0NyK2RlYlU2bFZGOUNPRFlrZFk3OENlNU9vOWVB?=
 =?iso-2022-jp?B?SlRCeGpKN3Q3Q3F3YUZiMi83SU9mSmEwNHFKNzVwTWVPK2tUNnIvd2ht?=
 =?iso-2022-jp?B?aEtseDZUMlBoM3VUMXFJZ3dhSk9VUVhlWmRMVkQzZ3RTUGFPRnBZUzFn?=
 =?iso-2022-jp?B?MjhNYmZ6UFZiWnlkV3UzOURXa0l0a3pGaytpYk9KRHJ0aFE0MEd4YXph?=
 =?iso-2022-jp?B?OVY5Ukh0YnBobkZGNjI4NkhJemZ0bHJ1c05mUURUYmk0eHFkVXhYOHI3?=
 =?iso-2022-jp?B?L3RvbU5JcDd3VEZwVVRSOGMwaU0raW9DZWF1MmYzSmF0TU5UcWIweEg5?=
 =?iso-2022-jp?B?Qk1tZjhtZm9QcDZSZ0RxSDdKM0x0MkZlcW1PQ25yUDhJcEtkSVFWcnlu?=
 =?iso-2022-jp?B?ZTZ2eXpaMUErbGluY3dzdXEvSzZxRHM4SlZDR04xeVBBb2owNVoxSnN5?=
 =?iso-2022-jp?B?Ui9WMWVsZU0vT3NpSm8yMU1xQzVoa3laSndINERESXBHbGk0bG92Qzg4?=
 =?iso-2022-jp?B?WU5hYXdaWVlNMlhYU1gzTEJGK2x2d1hpajBsRWN0dEVKSmJvZTdKVkhB?=
 =?iso-2022-jp?B?Rm14K3hkdnZ2NFpXKzNiQ2NyVC9vdit2NWhUTGRKVW1seUM0STY0Q0t6?=
 =?iso-2022-jp?B?MUYrdm9JQjN3TFlnYjJZTks4Skdvakxkbk1QMDdmbjl4MVh2cXpFY3pT?=
 =?iso-2022-jp?B?MzE4cUxtQXlJN1RobUhuNWNBcDFSMTZEb2l3RlF0cHI1d29RdGFINHRu?=
 =?iso-2022-jp?B?anBwZnN5WUlOSkErRGsyeDc0YWlEYzRQcjJwbVk0UHY1VVNuSEcxNm9q?=
 =?iso-2022-jp?B?T0l5UGhmdFkycjB4ditPc0JxYWY2QjNaY3FxRFFSK01QN2YwaEFsTUNP?=
 =?iso-2022-jp?B?VERKKzlmR2pRcG53SXBmYjJPOEdlR1RaMGNxMmk5am9qc3pCemJBa0Zl?=
 =?iso-2022-jp?B?NURzYUJyVDJxRzZjMjFpMEczVkV3NzNuM3VNTFljSjdrcWRWMmliVkV5?=
 =?iso-2022-jp?B?RVJOcFp4MGIySStwWVI0R0FpSG5RRVNPWjM2eWQrcFN6OTBoYkZnaWZN?=
 =?iso-2022-jp?B?VEVjcWZTREZBcjhXOUxIQkZPS3YxaVJqdWc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OSCPR01MB14838A7EC23773AD5E01E9410C28E2OSCPR01MB14838jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB14838.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d92726-cc77-41ec-cdb1-08dd8c02ddec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 18:30:09.7467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjRAwa0GsXHlHf3QXVeenhRe0eNbB/Gm4TlOGMgWGuhGQn7RDc3q7BrggSLKnB3lSwXC2YyWGZs0J9w6dkjLWR6Hvrd9+f00IsIDQGSV2HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13734
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 May 2025 18:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18761

--_000_OSCPR01MB14838A7EC23773AD5E01E9410C28E2OSCPR01MB14838jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Dear Maintainer,

Thanks a lot for your support. I have used the rule you mentioned in your p=
revious reply i.e. `/(usr/)?lib R` which would match both the symlink /lib =
and the target /usr/lib.

So, I initialized the database using the following command,

# aide --before "/(usr/)?lib R" --config <(printf "database_in=3Dfile:/var/=
lib/aide/aide.db\ndatabase_out=3Dfile:/var/lib/aide/aide.db.new\ndatabase_i=
n=3Dfile:/var/lib/aide/aide.db.new\nroot_prefix=3D./lib\nreport_detailed_in=
it=3Dtrue\nreport_level=3Dadded_removed_entries\n/ s\n") --init

Then, I observed that a sample file (testing.log) I have created in symlink=
 /lib has been taken as part of database entry.

Then, I explicitly changed the contents of that file and used the following=
 command to run an aide check to see if aide is able to detect the integrit=
y failure.

# aide -c <(printf "database_in=3Dfile:/var/lib/aide/aide.db\ndatabase_out=
=3Dfile:/var/lib/aide/aide.db.new\ndatabase_in=3Dfile:/var/lib/aide/aide.db=
.new\nroot_prefix=3D./lib\nreport_detailed_init=3Dtrue\nreport_level=3Dadde=
d_removed_entries\n/ s\n") -C | cat

And I got the following output,

---------------------------------------------------
Changed entries:
---------------------------------------------------

f >               : /testing.log

---------------------------------------------------
Detailed information about changes:
---------------------------------------------------

File: /testing.log
 Size      : 0                                | 12


---------------------------------------------------
The attributes of the (uncompressed) database(s):
---------------------------------------------------

/var/lib/aide/aide.db
 MD5       : ADJRIYHvODII3WZx/g2yLA=3D=3D
 SHA1      : 6udutnCV0tDjjuCyXaUbPG/qHCM=3D
 SHA256    : 5ei1zvwTTPdTcYKfxtu+9wMTD3vrFyyH
             yHilF5kbjTU=3D
 SHA512    : YhKb9/iz7k29/7IgLKZghc3LXwh6cx3R
             1ICyekDBW4ZFnkG8jP3xArmFzGEW9+6d
             dYj3PXJv0sfoNc3iixPk1A=3D=3D
 RMD160    : UREGEa1n2lMi2RojuIrsbMCUJY8=3D
 TIGER     : bjI+b86ImZ4Zb2GdQpapIm98RZDyof0q
 CRC32     : BbCDHw=3D=3D
 CRC32B    : vzaqaQ=3D=3D
 HAVAL     : 8BmciX62SafDPWwbG4bJLnMTN3HQXkCt
             ODmsnr2yx7E=3D
 WHIRLPOOL : hNuam1lHOyNC1hqCCHjbGJG+B83z5l1X
             nwV8+yCrPJOPuInRa9/BzkSUMPWWiTHu
             /jpMe4918vUQhDopTAG5yA=3D=3D
 GOST      : dLpRNm7FvZVJuDzJCyEJddvqwF6gNq5l
             BhY3FNa1O9w=3D


End timestamp: 2025-05-05 18:08:48 +0000 (run time: 0m 0s)

So, based on our discussion I think we can conclude that aide is able to fo=
llow the symlinks and the contents in it but we need to use the right rule =
to match both the symlink as well its target directory.

This issue can be closed if you agree with the above observations and concl=
usion. In case of any concerns, please provide your opinion.

Thanks and regards,
Sai Ashrith



--_000_OSCPR01MB14838A7EC23773AD5E01E9410C28E2OSCPR01MB14838jp_
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
Dear Maintainer,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks a lot for your support. I have used the rule you mentioned in your p=
revious reply i.e. `/(usr/)?lib R` which would match both the symlink /lib =
and the target /usr/lib.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So, I initialized the database using the following command,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<b># aide --before &quot;/(usr/)?lib R&quot; --config &lt;(printf &quot;dat=
abase_in=3Dfile:/var/lib/aide/aide.db\ndatabase_out=3Dfile:/var/lib/aide/ai=
de.db.new\ndatabase_in=3Dfile:/var/lib/aide/aide.db.new\nroot_prefix=3D./li=
b\nreport_detailed_init=3Dtrue\nreport_level=3Dadded_removed_entries\n/
 s\n&quot;) --init</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<b><br>
</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Then, I observed that a sample file (testing.log) I have created in symlink=
 /lib has been taken as part of database entry.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Then, I explicitly changed the contents of that file and used the following=
 command to run an aide check to see if aide is able to detect the integrit=
y failure.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<b># aide -c &lt;(printf &quot;database_in=3Dfile:/var/lib/aide/aide.db\nda=
tabase_out=3Dfile:/var/lib/aide/aide.db.new\ndatabase_in=3Dfile:/var/lib/ai=
de/aide.db.new\nroot_prefix=3D./lib\nreport_detailed_init=3Dtrue\nreport_le=
vel=3Dadded_removed_entries\n/ s\n&quot;) -C | cat</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<b><br>
</b></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
And I got the following output,&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Changed entries:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
f &gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : /testing.log</div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Detailed information about changes:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
File: /testing.log</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;Size &nbsp; &nbsp; &nbsp;: 0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 12=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
The attributes of the (uncompressed) database(s):</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
---------------------------------------------------</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
/var/lib/aide/aide.db</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;MD5 &nbsp; &nbsp; &nbsp; : ADJRIYHvODII3WZx/g2yLA=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA1 &nbsp; &nbsp; &nbsp;: 6udutnCV0tDjjuCyXaUbPG/qHCM=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA256 &nbsp; &nbsp;: 5ei1zvwTTPdTcYKfxtu+9wMTD3vrFyyH</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;yHilF5kbjTU=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;SHA512 &nbsp; &nbsp;: YhKb9/iz7k29/7IgLKZghc3LXwh6cx3R</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1ICyekDBW4ZFnkG8jP3xArmFzGE=
W9+6d</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;dYj3PXJv0sfoNc3iixPk1A=3D=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;RMD160 &nbsp; &nbsp;: UREGEa1n2lMi2RojuIrsbMCUJY8=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;TIGER &nbsp; &nbsp; : bjI+b86ImZ4Zb2GdQpapIm98RZDyof0q</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;CRC32 &nbsp; &nbsp; : BbCDHw=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;CRC32B &nbsp; &nbsp;: vzaqaQ=3D=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;HAVAL &nbsp; &nbsp; : 8BmciX62SafDPWwbG4bJLnMTN3HQXkCt</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;ODmsnr2yx7E=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;WHIRLPOOL : hNuam1lHOyNC1hqCCHjbGJG+B83z5l1X</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;nwV8+yCrPJOPuInRa9/BzkSUMPW=
WiTHu</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;/jpMe4918vUQhDopTAG5yA=3D=
=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp;GOST &nbsp; &nbsp; &nbsp;: dLpRNm7FvZVJuDzJCyEJddvqwF6gNq5l</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;BhY3FNa1O9w=3D</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
End timestamp: 2025-05-05 18:08:48 +0000 (run time: 0m 0s)</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
So, based on our discussion I think we can conclude that aide is able to fo=
llow the symlinks and the contents in it but we need to use the right rule =
to match both the symlink as well its target directory.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
This issue can be closed if you agree with the above observations and concl=
usion. In case of any concerns, please provide your opinion.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_OSCPR01MB14838A7EC23773AD5E01E9410C28E2OSCPR01MB14838jp_--


