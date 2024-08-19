Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC2CC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 09:34:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.206770.1724060047176948962
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 02:34:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 47J9Y4uv3754920; Mon, 19 Aug 2024 18:34:05 +0900
X-Iguazu-Qid: 2yAapsDzD7QheasRQ2
X-Iguazu-QSIG: v=2; s=0; t=1724060044; q=2yAapsDzD7QheasRQ2; m=qc3rSC/ey+op6VFcSt1TU8gGbev4k9oN2qABnVyiK7M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 47J9Y3B92462140
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Aug 2024 18:34:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6T1bV6h9EL7zHC1M7r/FhA7JoltYw0fpRRbGXlOBfRFTeJY3wjdTBa2uyr0fH6wyOu/LhDJZWqreJbs+Y/06rr2DDQVLSM2lD2zWBy/qUaJoRtKUkEfNBEiQ1w6H+j3F096PC5NTMMs2cBkwfMWVF0DxRcqq8KHfN09l0t64mhrI1CSdtluYcl0+RWOmkiWzX0Z0PeC+5ygf6q5bWjQEFYhQ/vIcgsG1D7prMeIH/+lwiVikJs4oHoNoi8HbugaadKscNmlD9J9MHesEnep5L+gjCwek6qAdtC7Y1uAmGlknoRMyXPzhf4YZLa+lmb5zQI1fCY0kHIzmUjLVNN4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FaPOQ0bOveBnNbXC6gXFm2JTjHTMmv8CXyegN8dUL2E=;
 b=uS+O4q6WN/KeKmK1VT6UJgrcWKwu49LIFjoT6JoPq2iurJWmse/k73feb55meI+cfRmHd6+RUK6BEAFlBmOgnJuIHYwO6rXVvVIjZODJj+kjqtprW1YQbytotRFpFK2cVdZtsVKmyhFwuxIGwXk1A8tv56TD7FNmT/f6ln9qUZmMaR8pfnaEqk8V6vwFOsZPBtWQm7E//9StBSI/2QZsApxCOQmS0N+m3InsDqdkJl4BmmsGL5cgzwMVn1oEAIkuO+ySn2WrEHLi1kMOdEk+uIT1QLOxKNSVyq3PMXGjJpwgPmgKYGhfHknOlqchaIw2OWAm2NSixX+12TjJpnOQMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
CC: <quirin.gylstorff@siemens.com>, <clara.kowalsky@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check
 file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook:
 Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE
Thread-Index: AQHa5xidS/08jmnS7UCshXxrlGICT7IuZW+g
Date: Mon, 19 Aug 2024 09:34:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103795DE9A6A06EF71DB552C28C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
In-Reply-To: <20240805091905.1818691-1-clara.kowalsky@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OS3PR01MB6935:EE_
x-ms-office365-filtering-correlation-id: 0e87716d-b7a1-4e26-54cd-08dcc0320ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZUl1QzIyOTYreDFzbTN1d1A0YVQvcWtpNXJyOEFEZmd1V3NUVFpvZHpZ?=
 =?iso-2022-jp?B?ZldUdVFHNVRHTklGL2hzNzF4bkZWL0xnNytDWUo2eHFlRTlVb0ZTV1lB?=
 =?iso-2022-jp?B?R29tbjN4ZjZkTzBielU2QkxCWlhZMU5FMWtVWnR6SUFCdFFSMlBhc3ds?=
 =?iso-2022-jp?B?ck1qTk8yMlpTS2dLYmRxaG1SZlhONmkwTXl2SU0xMmh1Tzg3enpvalZ0?=
 =?iso-2022-jp?B?MWdVRmxialFoRjNCN3FBcEdaRkhPaTBVdWFxQnlRRVBrM2lTQWhrN0Vo?=
 =?iso-2022-jp?B?VEhLUG9xZzZON0pST0YrZ092VjNVTlJaU1B1cFdXcUh1Yk9hZS95S1NW?=
 =?iso-2022-jp?B?djBGc1pFTGRDckFIbDhCUko0RldSZW5UaWw0NCtzU2pwVWRRenFmNVgz?=
 =?iso-2022-jp?B?bEptNytkNUJWdnY2TTBRN1JBS0ZEeTNhL21UZkY4Tk0zUUtmcEdBS1BS?=
 =?iso-2022-jp?B?RjFmTVhJZ28xQ1RBS2NBSGdwVE1WTXdQdGtCc3hCLy9jK3g4bWlyMExo?=
 =?iso-2022-jp?B?TDlpSFpPYUFibW93c2lFUStramdFeGEvdkxyZDZiSy9pSlp1K0gzZ2Nh?=
 =?iso-2022-jp?B?dTcrc3hiT0JkVFd6dUdleUtOTzhETUlYK2x0eDNMcytJWXNIMFl5TlFB?=
 =?iso-2022-jp?B?TVNrbXRPa2s1TittcWtPTHk0VWRjanRGdG00SkJJRElweWpVR1owdEF3?=
 =?iso-2022-jp?B?aFpGNlQzTFBoUUdhMHhDY1MzNFdPUGdmRktpaERaQzU1bFVUQzdLWGF6?=
 =?iso-2022-jp?B?UjdxNisrRkpaSkhYNjRrMUtQc2tYbURBL3JWUkRYMlI4NS9aTWRhOEVR?=
 =?iso-2022-jp?B?Q1AzNlVGUXlnZG83MTdwc1o4UXpuWkpTUU5haGRPQjVIOUE3cm9sYzdm?=
 =?iso-2022-jp?B?K3BZbitSSmFvTXRRcEp2YU1QWDd5Slkwdm83Z0FYSE1taFNkL0R3bGpJ?=
 =?iso-2022-jp?B?Ryt2YVlUbEhlaTNmUDk4SmR4c3dyTHNhaFN4M25qM29RMktQc1h3Q0t3?=
 =?iso-2022-jp?B?NUMvejVOMnZSOGdnN282dzVaNnovQzhUcytRcXlRL2ZndWhWZnlROS9K?=
 =?iso-2022-jp?B?bHF1SUgzNlhoajRxVFlQTmZ1NWJFUndTQmRjZ2R2RDFVTUFKeXluQi9P?=
 =?iso-2022-jp?B?VTBrRUNidkdaMkRnZHQySnlxMjZpcERvb08xb2Y5bHExWkkzNzIrNzhB?=
 =?iso-2022-jp?B?VCtRcW5jTHl1NU1LWTFMS3cvdlZ4VXBiUDBkWDJQZWk5YjB4c3lTUCt0?=
 =?iso-2022-jp?B?Ym5kc3BkZVZ6Mm9idWdvYkYvbWFLamdRendQY0R2eUhkN0tHL0xndk50?=
 =?iso-2022-jp?B?ZEJyWGJYazd5K1pEdkZjZDBOL2RrL0VsQ1ZMQ1F1SmJsZXJrWDlxbFFq?=
 =?iso-2022-jp?B?cnVrVHZZd2VydWgxTUsyN3UrYU8wcm81ZWtjWmRpOGFLMTA4WEZIdlBJ?=
 =?iso-2022-jp?B?ZENnbVBTV0lZdnZhbWszV3pVSUg3TUVlN3JSN0prbmpXZ1hjUFY0d2cx?=
 =?iso-2022-jp?B?VXZIU3NBbHRrdWcxeGN4MGdxc2RxdGtQUEZ6a3BRL3hodkJNQlNYZXRD?=
 =?iso-2022-jp?B?M1NBOUxQSUxpYlZpSGpjcFVCNHc0ZitPTHNUT0V3SWNPVElNOVd0cmhJ?=
 =?iso-2022-jp?B?R25VS0hkZUlTTVowRjZsU3EwV2hqaGY4elhreWlRbUl4U2Y5bzUzWHBJ?=
 =?iso-2022-jp?B?THI3b25nQkpoRXA3SVZJNDV4RHJQejVkLzJ2c1hhbGx4MFV1M2EwZnQ5?=
 =?iso-2022-jp?B?bXNoVVc0aU5NYkJEYkluektNaEd5TWR3R2Y5TEJyeGFaelg4YmhUUmFC?=
 =?iso-2022-jp?B?NGlId2taWUQ3cG5uUHIyNW5BcnlxSWlPbzFZVS9CZTh3Mk1qdnZjZDEr?=
 =?iso-2022-jp?B?bEtSZTNFamEvdFV6cXpjT2djTlo1VitKcW1mRFBYQXpRTTZ3M2JXcS81?=
 =?iso-2022-jp?B?cEcwQzczNStsMXJrblRCQWdwbXQ0UT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?N1BuRjhqczlBbGZIOWI0QmV0UEw1b2xjVWJCL3dLK2U4YWk2eGdkWG85?=
 =?iso-2022-jp?B?eUd4Y3orZmZCUy9UU3VPQU55MUNGZ0NJaWN6Sm5yKzZLSHc2NWhFeUtU?=
 =?iso-2022-jp?B?Y0dBWklyZVhvdVVNd3BURzViaGdVaE9BNzljdjV1SEE0UDNraFBYM3Zv?=
 =?iso-2022-jp?B?RVlvRzI3SnNQV1dFSVdvUWxWTVdvaFRNeUQ3Tit1TXJqTU8zVmJTR0Ni?=
 =?iso-2022-jp?B?N1FwSHRJTGdsbXFZMEtCNStGMGdPYThLSkpxZUhxQ2R0Nzg3RWNWRytG?=
 =?iso-2022-jp?B?TXhqTjdGOUxLaHErMDliRWpkam1oSERIZ0tIb0JNYlY1ZFV3bHByMVRL?=
 =?iso-2022-jp?B?WkdER1NsRk5sc3ZmWUdqb3NpaGNBZFlGL0NBQk5aMEV1V09pUDlUYkhJ?=
 =?iso-2022-jp?B?OG1xWDc2bmFUMGdnOFpsMUV5ZEhlVmJabFlvMXJUaVh4eGxyU1FMbnN3?=
 =?iso-2022-jp?B?SUlqWVBZOWhobzFxODVMeE10UUlUSVE0b0VTNmxSZ3VCTWp2TjNQR2hk?=
 =?iso-2022-jp?B?TklHbmZqTTR3VXE5TDhpTVVNWERWeFhQMENIVU1pTEJjZjJGdDNFN2pq?=
 =?iso-2022-jp?B?SDNNdzBNUVVseUJyREUyeDZkaHhJeGN6KzNwYlA4cjEvNnU5WUZrQStL?=
 =?iso-2022-jp?B?R1R1ajV2blJibDJmb0RCa3BGUm8wUVZqRFl0ZVF1UlYvaFVaVWZGV2ZT?=
 =?iso-2022-jp?B?T0s1TXVpT2dFMEUwODVxbTRjZ3Z3TWwyalhsU1RtUmhoK0hySi9tdFF1?=
 =?iso-2022-jp?B?ZzhSNFNBNmNjL2Y5UEdiYW5LQlY5N3A5WmpseFg3cFhic0FOVWdwU1FE?=
 =?iso-2022-jp?B?S3ljOTRhTlVrK203UCtyUGFMem1SOWlUcWJzSzBBcENEODRsNGRsMmVq?=
 =?iso-2022-jp?B?M2pKeG53K1BrM0d2d3VWOUxxYm1xSWF1SVFLSkFtTDcydGZuU05uamI2?=
 =?iso-2022-jp?B?L2hPR0JLZnptTWc2THhzTzlVQTEwZnU2aDNIWG5VNVlveTJpRGY5dUVr?=
 =?iso-2022-jp?B?S2Zha3BmeDRIMU1ZQ2tuYk54WDA1VGJLM1RjVUwwemdmWmRJbDZoa2c2?=
 =?iso-2022-jp?B?ZUwveXc2TzEzSDZJZ3lSZkpqbmxYTTRLdXA3L3NXREUyRGVmbGNvdlFT?=
 =?iso-2022-jp?B?MmN3ZzhTOEF4R3pka0R3UzJDbU5yMVFrRzJjRFJUQ1RwbURHUWxyL2xM?=
 =?iso-2022-jp?B?RWJXajg0Tmk2Qk1MS1RwbDBDUXVVemVZTGdrZHp2c3JJa2FGak1jZTlI?=
 =?iso-2022-jp?B?cGVJY0svK3NFY3dJNGlTS29yMHUrVkNpVW03WnYwN05FaGdET3crT053?=
 =?iso-2022-jp?B?VzRyVXQ4bFlVcjFYLzBQdnJnVmM4OWNDdU1YYVUrUGs0VnppbUVLUXZL?=
 =?iso-2022-jp?B?b2pkL0pDOUJ3dTBudDB4RUUrY200QlVTYVFFOFdtTTMybEFEc0VZeVV6?=
 =?iso-2022-jp?B?dmc3OVpwNjFBQmZPTmE3dHRBWUsvSUVNcG1IVFhGcFNoS3p4SVhzcFkv?=
 =?iso-2022-jp?B?Uzc1TE1SV3dxd3FkS1Jmd0xQT0Jqb2lFRmZVdno3UGtseUd3d3hkbmxh?=
 =?iso-2022-jp?B?RlRHa1pxUDhiZXhVUjBTM1QvQXg3bEl6ZC9tZFAvMzZNMWZaS1FSNTlK?=
 =?iso-2022-jp?B?Zm1SbEYwd1NNNG1lejN1ZW5uUDQycGhVdFBucmhPaVo4ZE9yUHlneU9q?=
 =?iso-2022-jp?B?T3F2cFBqdTcwZEZ3eGswUU9haEVwSUd3V0xqWTFZaHVFaUU2VVNIcEFq?=
 =?iso-2022-jp?B?MlJONy80N2VSdXR3bUpsOG11RGRXcFMzVm1jcnI0M3BLUDJpWkw1QkFC?=
 =?iso-2022-jp?B?WlViZ1ZqYU9UekpYeDFuaEt1b2xZdTl4ekZTNE9MNWZUd1BWVnpPd1N4?=
 =?iso-2022-jp?B?bllPd2VzRy9oR3NndEFzUGJ5enFSWkhLRGwxMUVGSDMzUjJvSitkcTFC?=
 =?iso-2022-jp?B?bWRjdjY4SEkxQkN1YUlha2tqRTVaWW4yeEtuWjQ2b0xaUFd2cUVpWGFu?=
 =?iso-2022-jp?B?anFUSFQyMjBrbDFvQ2hkRWRrS2F2MVVVMFhpamxBZGpCUUc4dFJlVW52?=
 =?iso-2022-jp?B?M3RxeVBkcGJsL093K3l1Ymw5Wk5QSlVERy9uejl0d3NNK1VOZlk0ek9B?=
 =?iso-2022-jp?B?TDZzVFI4UXM3SW9FaEtHdXpaTGdDVUcwY0o1QnV4VllRSysxaE5SeWhx?=
 =?iso-2022-jp?B?N3J2SVFPMnJLUU8rczZabjBoY0JlQkM3Y3VsSjEzVkE4WFAwVGZ1UUdz?=
 =?iso-2022-jp?B?SHJndXpTQkU3akRaMFdEUStQWlVFVE9Ha3M2cWJMT3dNZnlQQkhDY1dq?=
 =?iso-2022-jp?B?akcvSnZjVXFFTCtZUEwrNkl4a3dpUlkyNGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e87716d-b7a1-4e26-54cd-08dcc0320ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2024 09:34:00.7696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VSKoHXNEGyWeJ73mmss0lPoLsfmKem7T/GBiI1lewLZpFKE2F0IrtIseqhOejwl6pKsuLLmu65PO3PshalSCZ8Eh4WHSiGDmK3/sYag3IRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6935
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 09:34:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16794

Hello all,

File system errors are detected in `/dev/disk/by-label/var` which is trigge=
ring `mke2fs` to re-create the file system during reboot.

In LAVA jobs, mke2fs is asking for proceed prompt (y/n) because of which al=
l software update jobs get stuck leading to a timeout error. -> https://lav=
a.ciplatform.org/scheduler/job/1180009#L1213

Currently I am not sure why file system errors are detected in `/dev/disk/b=
y-label/var` during reboot, but this needs to be handled in software update=
 test automation may be using mke2fs -FF -t "$partition_fstype" "$ovl_parti=
tion_device".

I request everyone to provide their opinions.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

-----Original Message-----
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Clara Kowalsky via lists.cip-project.org
Sent: Monday, August 5, 2024 2:49 PM
To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com; Clara Kowalsky <clara.kowalsky@siemens.co=
m>
Subject: [cip-dev] [isar-cip-core][PATCH v6] initramfs-overlay-hook: Check =
file system of INITRAMFS_OVERLAY_STORAGE_DEVICE

In case of ext*, this detects and fixes file system errors in the partition=
 device before doing the partition mount.
If the partition turns out to be broken, the factory state is recovered.

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.hook      | 11 +++++++++--
 .../files/overlay.script.tmpl                      | 11 ++++++++++-
 .../files/overlay_recovery_action.script           | 14 ++++++++++++++
 .../initramfs-overlay-hook_0.1.bb                  |  8 +++++++-
 4 files changed, 40 insertions(+), 4 deletions(-)  create mode 100644 reci=
pes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/=
recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index 8b00ecf..6f634c5 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -22,6 +22,13 @@ esac
=20
 . /usr/share/initramfs-tools/hook-functions
=20
+hook_error() {
+    echo "(ERROR): $1" >&2
+    exit 1
+}
+
 manual_add_modules overlay
-copy_exec /usr/bin/mountpoint
-copy_exec /usr/bin/awk
+copy_exec /usr/bin/mountpoint || hook_error "/usr/bin/mountpoint not found=
"
+copy_exec /usr/bin/awk || hook_error "/usr/bin/awk not found"
+copy_exec /usr/sbin/e2fsck || hook_error "/usr/sbin/e2fsck not found"
+copy_exec /usr/sbin/mke2fs || hook_error "/usr/sbin/mke2fs not found"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.=
tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 42eb59c..c655a4f 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -31,12 +31,21 @@ ovl_partition_device=3D"${INITRAMFS_OVERLAY_STORAGE_DEV=
ICE}"
 ovl_storage_path=3D"${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs=3D"${INITRAMFS_OVERLAY_PATHS}"
 ovl_mount_option=3D"${INITRAMFS_OVERLAY_MOUNT_OPTION}"
+ovl_recovery_script=3D"/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
=20
 root_mount_storage=3D${rootmnt}${ovl_storage_path}
 storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2=
}' )"
+partition_fstype=3D$(get_fstype "${ovl_partition_device}")
=20
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
-	if ! mount -t $(get_fstype ${ovl_partition_device}) \
+	case $partition_fstype in
+	ext*)
+		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script"=
 ]; then
+			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
+		fi
+		;;
+	esac
+	if ! mount -t ${partition_fstype} \
 		 -o ${ovl_mount_option} \
 		 ${ovl_partition_device} \
 		 ${rootmnt}${storage_mount_point}; then diff --git a/recipes-initramfs/i=
nitramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initra=
mfs/initramfs-overlay-hook/files/overlay_recovery_action.script
new file mode 100644
index 0000000..d13111d
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_ac
+++ tion.script
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com> #
+
+partition_fstype=3D"$1"
+ovl_partition_device=3D"$2"
+
+mke2fs -t "$partition_fstype" "$ovl_partition_device"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hoo=
k_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_=
0.1.bb
index 955748f..7097130 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.b=
b
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.
+++ 1.bb
@@ -12,9 +12,12 @@
=20
 inherit dpkg-raw
=20
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D "overlay_recovery_action.script"
+
 SRC_URI +=3D " \
     file://overlay.hook \
     file://overlay.script.tmpl \
+    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
     "
=20
 # The variable INITRAMFS_OVERLAY_PATHS contains the directories which are =
@@ -35,7 +38,8 @@ TEMPLATE_FILES =3D "overlay.script.tmpl"
 TEMPLATE_VARS +=3D " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
     INITRAMFS_OVERLAY_STORAGE_DEVICE \
-    INITRAMFS_OVERLAY_MOUNT_OPTION"
+    INITRAMFS_OVERLAY_MOUNT_OPTION \
+    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
=20
 DEBIAN_DEPENDS =3D "initramfs-tools, awk, coreutils, util-linux"
=20
@@ -48,4 +52,6 @@ do_install() {
         "${D}/usr/share/initramfs-tools/hooks/overlay"
     install -m 0755 "${WORKDIR}/overlay.script" \
         "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
+    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
+        "${D}/usr/share/initramfs-tools/scripts"
 }
--
2.46.0



