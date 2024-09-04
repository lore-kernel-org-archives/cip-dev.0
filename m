Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C5CD37B4
	for <webhook@archiver.kernel.org>; Wed,  4 Sep 2024 11:53:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.48055.1725450787243869950
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Sep 2024 04:53:07 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 484Br4iI1999614; Wed, 4 Sep 2024 20:53:04 +0900
X-Iguazu-Qid: 2yAaj8ZU2hc9TzHhMQ
X-Iguazu-QSIG: v=2; s=0; t=1725450783; q=2yAaj8ZU2hc9TzHhMQ; m=9Rc21TD/Ua0Ley76OSLfmZF/UP7pt4qnkjvYN55NT6M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 484Br2Vj3281812
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 20:53:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJR/9F/Rga7fssatV9yNi+IIFGwzJkjzERkCeX2k593KnqhQCTSNgzdQ699m2WHQe2KL8HFAl7OX4Nu7N2UPOMymU1MN554UdGU02bDoD6WYATRvK1GD6LQ5XcIHDrdECfeqs/T571gPLteSIJinp6phxMq8jWqOZhqE9dmdgfi3eYfHbp/HoCdI7D2uYWBjTXEZhWck5OTkBPXsX2988Z6BqULvGjOEwluWtIpm0Sp3zO48r3EC9pJHsHOR0qOtw0xAJzzhbitNfWOuEldDg88+ilq1kEbMhGgwNGRIx2TerQu3gr5bt/wIs4oUBHuyTsvN6fyZWZnRg6M9HaehZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIgxrSX2L/gothGXADgPodaHUNGMM+Q7O1a2qCxifvM=;
 b=TXKxfJYqqsHXFgF+uYAUWN4lxCyGApVqyI1Y7QrXWsP+ENTP7PCQsB3WDAYza92ok48s8UnoH9wq6wGp0akd/ZzB0kut/1lvozoFKw/AnQhBmD/bQ5tPoHhmlayyV0VUMuFwyoVdHeiY8uqqto1N3SGGINlQwJyGiXwh7yFUngmVUkx+GTgNnTKV0f5rRvqeP+XnEUpszIJVhOkD8XwSeCabGLXx1llc/9lsAaK9L4zM7bjVxZL6mrAMOnYFK9WXDs4F82XXrFG6m6hhNgvvK3t3VyMLc/ZK/WMkTlvL6NSb70k1/KgyKmGrOyaQflnnJ/NqCkfLWO51T5qbTXNxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <michael.adler@siemens.com>
CC: <Chris.Paterson2@renesas.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] Issue with 'small' Gitlab runners
Thread-Topic: [cip-dev] Issue with 'small' Gitlab runners
Thread-Index: Adr6EQ3RL8rQAtQSSy+tF4/i30H+FAACvaEwAB6AvfAAoAnrAABqrZEQ
Date: Wed, 4 Sep 2024 11:53:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61035250A83977730E393D70C29C2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103DA72FFDEBC407A5900A6C2962@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB12402CF459412685A6824CB45B7962@TYYPR01MB12402.jpnprd01.prod.outlook.com>
 <OS3PR01MB610349E8EFC2F9E8ECEBD450C2972@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
In-Reply-To: <cnkp47rzuahu7yls5ch2mi6okr6w3uevw6eqehmc3ti3f6zesu@of6ittbitant>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYAPR01MB5820:EE_
x-ms-office365-filtering-correlation-id: c620632f-4924-4188-d9a0-08dcccd82036
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?SGM2Ykc4a0lmWXIvWjVpM1g2OHVxRTNKWnhVWGY3TXJzNGkzR21oR0JYLzdq?=
 =?utf-8?B?NUY4clRmU2d0aVFDR056YUhVU0tJcGdlcTJ0UEUzdDAwYllka0hWN2NoOUV1?=
 =?utf-8?B?MWNHTTVKUndhN3dDNUVLRVR5Uy84ajZNTEJiQ1ZXakQ4ZmYxRDVRWjVJRTBR?=
 =?utf-8?B?U0ZneWRaTkZ5YWVaaEV5VmhSNTVRS2gxTkFNakhRRlhSQ0lvODhTcEFLRU9P?=
 =?utf-8?B?cHptUk5XMW53amtKbTdQMWluV0IyMVQwTUtXclRBV1VhSGNIQ1RTRUsvNndR?=
 =?utf-8?B?MDBFNUs4RzRFbkdzSDBHL2RrYTVGUlI3WUk3QXI5NFhOc1hSaEZHblorS05k?=
 =?utf-8?B?Q21vWkcycW1XMHF4dkJhYm5UZnVacUJoVzNwM3FRSGcxSS84VlNsQzZ3bFFo?=
 =?utf-8?B?TVRXNi9CcUJtQVZEQkdxeTA4SlZRMk1tVW9KeXdQQy9ZYStTZ1RuZ3R1Q3py?=
 =?utf-8?B?SEFMcFlHRjljRy9KSDNGSGVqdTFGVGtFRCt4aHFUTFRTdmtLRmxVVW5heC90?=
 =?utf-8?B?MVk0T0xwSWFuSmVhcDdrQlVtQjBKdGN3a2duajFlMFZOZ1JTaHV1cGMzYTlI?=
 =?utf-8?B?Y21Lb3B0Q2g5ZXBJZVBQMFpXNDVoMXBSSmZqbGJtb005YVRaWFMxcTNGYmRJ?=
 =?utf-8?B?blBhaG1iUC9OZ0RCdnRrelFueWRmZUIyMnh2SENuYStxQVBvNFlNYi9wazRI?=
 =?utf-8?B?Q3pqS1NpaDNvRmVKcGlrTUY5NkdwRU1sVG9ramhFZEMwalUyK1BoTVZubFRo?=
 =?utf-8?B?RDMvbEIxY2x3NmlycjE1M01PVTNCdFRTMVVWMnE2Qjc2OElCbmZ4dHN1OHZP?=
 =?utf-8?B?Zit2OTRndFhlb3ZvdTJRM3dpQXhpQkY0QmhjY21PY0MwNHFYT1I1SUxLQjFS?=
 =?utf-8?B?cWFxdlBjOG1NUU1uNHR1RVlnZlRXYjdVWks5UTdDbW9kcWlLK2NkRU9kS0xw?=
 =?utf-8?B?dy9PbVdGVms1SHZlMGdWd244OVFaTS9rUFNrRG9ZWXBuQWdWK2hZNHJZaHlq?=
 =?utf-8?B?dHNaUkxvN0xSemdKamxWR1FIY2g1dk1UdnRSZCtrTFcvM3VCVEZYOTh5OXNu?=
 =?utf-8?B?aFltVldETGJEVUErcGNpcUJ3TUVMeEpnZzhtTzlKcWxlRUlXN3V4dnlTSjRY?=
 =?utf-8?B?K0J5WnhhYlFML2J1ZWdwMWtLbjVVK28rQ1dLdWdtTHJEdWpDK3EvbUVLMEp5?=
 =?utf-8?B?eFhDK0dLNzgwTDNjNjlZYldUMnZ2QjAxUHpaZ0s5R3RKL2RFOTBkbHJta3NH?=
 =?utf-8?B?d01NZkRxUlVKRUp4cFdJaXBWS0pWVHhkT0Z1YUlCNVJ1Qm9DckluU0kzT0xL?=
 =?utf-8?B?L3Fvb2JDWEg1dVpQWFJDemNYQzA5M3U5UEcvbDZMbEszSnVIWkoxZ3dlRzNH?=
 =?utf-8?B?Q0l0bGZZMlpDU3A2aE41cTlydW1wSGR3Q3k3QXBVYU5XSTR6QkNDT2FMeEhx?=
 =?utf-8?B?V055U3NFODRTcjloSzJ1aTJBUjcza002U3RucXFOUk9hSG9KQVJzZW1MYmI5?=
 =?utf-8?B?NGliODJGUEtJV1dJTWlwU240a1BLM2VvcHFaY3NxQWZycStEdWhxZFAyM0Jk?=
 =?utf-8?B?Ry80K004QVQyUkJ1U3d4TTFGV2dsc2kvYS9DZktsQmtKTDJxZzE0bStwL3dv?=
 =?utf-8?B?TlhvSFhGMEhJUVhzT3RJZDBvUmhncG92dEVWR2I2Unh0RkZTbkdHdlRWRUdr?=
 =?utf-8?B?ZTBMTWgwMldRZWgrMW94dzJJajJJN1lmSWl1dDhCZUFBT1lYbDhCb3J5R25p?=
 =?utf-8?B?R016SDhIN2xxeDk0OTFmTGIvRjBLcnRyZjZnTURVci9ZNktVSDhsN1FWUnJi?=
 =?utf-8?B?akxMUm1qSzlPR25XdVZLY3QzSHdoVklIUURvSXp1N05Udm95d3cxT0VBTDIz?=
 =?utf-8?B?eG5EcEV1ZEFEdHhaWHNDcU5URzJ3WHFXb1craUpJVWU0TDNjK0ZkVUhsU2pK?=
 =?utf-8?Q?GJQUIl94A/s=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bVp4ajVwdzQveVFDeDMzMkhGbTFNUjlCWXNDejExcHd5ZnhTY0w5MGpvb3pW?=
 =?utf-8?B?QzlsSVMvQnVOTEtrbHFsM0hDb3U1amFxbjhMb1ZPVlh1aUptVHNFdXNuK1o3?=
 =?utf-8?B?ZE9hckl5V2pvQzVpRXFHNGFCa0t0VnNGVzZjOEk1Qm40UTErLzcvWHNsTFEx?=
 =?utf-8?B?dWRYRkpqNXg4dm4veFRIWlE0WnFLVFltamViVHdSTmtiNFpHVHN6WmZ6UmpF?=
 =?utf-8?B?TGtEemFVSG5HRzJETGNCZlJ6U2t4R1ZzYW5xaDJZdG9xMjBRdlhhR014UXE5?=
 =?utf-8?B?STNyQmNpcjZEbGtkWjI0TTFUNkNHR2h4VE5NVVh2MUZPZHdLcCtYdkhNUmx1?=
 =?utf-8?B?VlpnSUlPanJremFadDIvck04VWNmTzdZcTM4RmtjUmRISThEQXRmVUdpdVY0?=
 =?utf-8?B?VkozS3ZMR1B1QXMxMVRMeFNUNmpldndhMk1kYjlTVHZaS0hQbXg4ckU4VnU0?=
 =?utf-8?B?M2hVSi9oU25TQlF4a1p0cWFzZDNmR1RTcnk1UzN4Rkp5clZVMGdBVzU2YVBx?=
 =?utf-8?B?MUQ4eFRKTDF0VUdjQWxhK3o2OUNXeS94c3Z3ZXF3TnQxRmtsSjVVUThObUYv?=
 =?utf-8?B?c09IQXFObFhkMmkyVzV3dncrM09lOHF6VU5YeFU5TlBkQThYUktoYmxoMG1m?=
 =?utf-8?B?TVFaWGNmQ2tWMC9KbjlRRUI2MXhEeTVYZS9DOFBtcGc2NWN1U2FVZG9tRVhQ?=
 =?utf-8?B?RlltUUlSWkhLNC9obnZBd0FPbzdxQkpyWnJSNk1aOURDZXdoQUhqaUtjTmlD?=
 =?utf-8?B?MVRTQlVTaFk2WGcwdTJJK1FJK05sVlViektzeEF6RnJPOU82bzQrNTFaYzkr?=
 =?utf-8?B?bDJrT2JVT2ZKUngwUUllMk10Z3RhWEdjNjNGWHFHK2ZrVDJkOUlPMHRRTjNT?=
 =?utf-8?B?SytiZFBRN09SZ3RteHJCcjRNVXE2WTNCQ2JCdm5iK0NFb2hwSVdrYVYvbVBr?=
 =?utf-8?B?alA1ckNISFh0Q2JMaU9OdmtTY2xMNG5kTnJnOForRGovTkpWOVloTE1NUXJk?=
 =?utf-8?B?MU9nOFlNTE9WM2w0cklHbkRrZ1RxR2l5SXY4NVZ4TDY3VEZaZ1Brb3lnazha?=
 =?utf-8?B?cVFMMUdycWp6QkZMVjJRbzY4QTh1czg1SDMrU3BYMmlHbXcxRU5BUVlpZ1FO?=
 =?utf-8?B?VElERXIvQ0NpRUJ4ZE16MHJmaTE5NXJ4bE15NEljeklEcWFNbkNtUGUxV1Rp?=
 =?utf-8?B?YzN6WWNQUi9URWtJcW9HMjVSTUJES0NzdHdNRk5mTnRjdWdnTHlFU0F1TzRI?=
 =?utf-8?B?ajdWUkFmKzN3bjFyN005YVBMdWhsVGFlcXFYanVCN0taOWlMZWRNTFNIc0Nq?=
 =?utf-8?B?bzRZUmpvZllqZnloTWF4cytEQTlzL0R2UUJMK09kQkhQejUwVitHQzl4WlF6?=
 =?utf-8?B?ZlVYN1VOTTh2c3ZYdWZrd01iTDZlTjB4cGxqRmpCTGx2RnZzL0NuVktvQXBa?=
 =?utf-8?B?M1d0eVNxUGYvd2U5RlN5UVRDcG5GS050cmdHOVhEUUVDM3hwdnpMOEpKN2Rm?=
 =?utf-8?B?d0x5eVdMemZDUFdVQ2dGRkRwdERtYStCL0kreEZvSTNnUGtXcGhpa3RFM00r?=
 =?utf-8?B?ci9uMEkvK3VFbS9jRm9BQUM0Uit3TU4yZXlSYkFQZGlyUnNwd0VjVlA1NXA1?=
 =?utf-8?B?TUNxRTZ0SG1KTU5KWmpjY2Ivck1lM2ZpRVFzUmlQemRhSGhXS3BiV2RrdHhK?=
 =?utf-8?B?U1k3cFc4VExmTU51NTB2OUZuWGxUZlAxVnZkeWRnZmdNZmVSZFQxcTh3SkNz?=
 =?utf-8?B?ME15dVg0VUEzdWRRNDNXMW1IOFE5K3hjRlFhL0ZjRzFkNlRFRWF2by9oWnFl?=
 =?utf-8?B?aGF1T01NMXRiczRLSEsybXE2akszZCtCbEs3WXdSeCtadVVDanRRU3h5VFY3?=
 =?utf-8?B?UllaNWtwUW1PVk1CRFFHdHdMZzNXa2cvcTJDbzNHTHJZQ2JQYWRBSzZ1dTBm?=
 =?utf-8?B?b1hBdkNMK0lUZ2wyYmsvdFJqMXQwaFVTM0RuQkFkV1I0VG5JWmpGTFEwdXNI?=
 =?utf-8?B?bUZac0txTWUybkpPRGtwTWRIL3N2bVl4ZzFYZVhSS3R3OWpSWDlkSUl3K1dZ?=
 =?utf-8?B?VzhjZENaWVNma2VlNStLSFdjWDNoaXBFcU9GSU1ucm9SRFk1WHY1T3lod3k3?=
 =?utf-8?B?M1VIbEw2bmZROHJGVEpkbXMramIvYzZUbEJFQ2N3WFpEeUdhVDJJZmtRNmJz?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c620632f-4924-4188-d9a0-08dcccd82036
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 11:53:00.4771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhcYJm432QJxw9gw9nUhNB/bXfnYL7bdlCUhmJUyuhbnVaj68GJNY6sSOuJCSv2n39eW4QNTxW72lDLM8r1mlxJOhuytoKT4dTjZVc42vFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5820
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Sep 2024 11:53:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16845

SGVsbG8gTWljaGFlbCwNCg0KSSByYW4gdGhpcyBqb2IgbXVsdGlwbGUgdGltZXMgcmVjZW50bHku
IEkgYW0gc2VlaW5nICdwb2RzIHJ1bm5lci16d3Nsd3k5ZXUtcHJvamVjdC0xMDE5MTMxNS1jb25j
dXJyZW50LTAtMmZkcjRxbGIgbm90IGZvdW5kIGlzc3VlJyBhZ2FpbiB3aGlsZSB1c2luZyBzbWFs
bCBydW5uZXIuIGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNp
cC1jb3JlLy0vam9icy83NzQwMzUyMTI5IA0KDQpXaGVuIEkgcnVuIHdpdGggbGFyZ2UgcnVubmVy
cywgdGhlIGpvYiBpcyBzdWNjZXNzZnVsIC0+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vam9icy83NzQyMjgzOTg0IC4gVGhhdCBpcyB3aHkg
SSBzdXNwZWN0ZWQgdGhlcmUgbWlnaHQgYmUgYW4gaXNzdWUgd2l0aCBzbWFsbCBydW5uZXJzLiBD
YW4geW91IHBsZWFzZSBwcm92aWRlIHlvdXIgb3BpbmlvbiBvbiB0aGlzID8NCg0KUmVnYXJkcywN
ClNhaSBBc2hyaXRoIFNhdGh1am9kYSAoVCBTIEkgUCkNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnIDxjaXAtZGV2QGxpc3Rz
LmNpcC1wcm9qZWN0Lm9yZz4gT24gQmVoYWxmIE9mIE1pY2hhZWwgQWRsZXIgdmlhIGxpc3RzLmNp
cC1wcm9qZWN0Lm9yZw0KU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMiwgMjAyNCAyOjI4IFBNDQpU
bzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCkNjOiBDaHJpcy5QYXRlcnNvbjJAcmVu
ZXNhcy5jb207IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDvvKTvvK3vvKUg4peL77yk77yp
77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8zLmhheWFzaGlAdG9zaGliYS5j
by5qcD47IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5l
c2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT4NClN1YmplY3Q6IFJlOiBbY2lwLWRldl0gSXNzdWUg
d2l0aCAnc21hbGwnIEdpdGxhYiBydW5uZXJzDQoNCkhpIFNhaSwNCg0KPiBJIHRob3VnaHQgdGhl
cmUgbWlnaHQgYmUgc29tZSBpc3N1ZSB3aXRoIHRoZSBydW5uZXJzIGFzIHRoZSBqb2IgZmFpbHVy
ZSBtZXNzYWdlIHNhaWQsIOKAnFRoZXJlIGhhcyBiZWVuIGEgcnVubmVyIHN5c3RlbSBmYWlsdXJl
LCBwbGVhc2UgdHJ5IGFnYWluLuKAnQ0KDQptYXliZSB0aGVyZSB3YXMgYSB0ZW1wb3JhcnkgaXNz
dWUuIEkganVzdCBsb29rZWQgYXQgdGhlIGNsdXN0ZXIgYW5kIGl0IHNlZW1zIHRvIGJlIChpZGxp
bmcpIGZpbmUuIFNvIEknZCBzdWdnZXN0IHRvIHRyeSBpdCBhZ2Fpbi4NCg0KS2luZCBSZWdhcmRz
LA0KICBNaWNoYWVsDQoNCi0tDQpNaWNoYWVsIEFkbGVyDQoNClNpZW1lbnMgQUcNClRlY2hub2xv
Z3kNCkNvbm5lY3Rpdml0eSAmIEVkZ2UNCk9wZW4gU291cmNlIEVtYmVkZGVkIFN5c3RlbXMNClQg
Q0VEIE9FUy1ERQ0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMNCjg1NzQ4IEdhcmNoaW5n
LCBHZXJtYW55DQoNClNpZW1lbnMgQWt0aWVuZ2VzZWxsc2NoYWZ0OiBDaGFpcm1hbiBvZiB0aGUg
U3VwZXJ2aXNvcnkgQm9hcmQ6IEppbSBIYWdlbWFubiBTbmFiZTsgTWFuYWdpbmcgQm9hcmQ6IFJv
bGFuZCBCdXNjaCwgQ2hhaXJtYW4sIFByZXNpZGVudCBhbmQgQ2hpZWYgRXhlY3V0aXZlIE9mZmlj
ZXI7IENlZHJpayBOZWlrZSwgTWF0dGhpYXMgUmViZWxsaXVzLCBSYWxmIFAuIFRob21hcywgSnVk
aXRoIFdpZXNlOyBSZWdpc3RlcmVkIG9mZmljZXM6IEJlcmxpbiBhbmQgTXVuaWNoLCBHZXJtYW55
OyBDb21tZXJjaWFsIHJlZ2lzdHJpZXM6DQpCZXJsaW4tQ2hhcmxvdHRlbmJ1cmcsIEhSQiAxMjMw
MCwgTXVuaWNoLCBIUkIgNjY4NDsgV0VFRS1SZWcuLU5vLiBERSAyMzY5MTMyMg0K


