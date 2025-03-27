Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8AFC36010
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 14:36:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.51355.1743086180916289547
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 07:36:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 52REaIPZ3376763; Thu, 27 Mar 2025 23:36:19 +0900
X-Iguazu-Qid: 2yAbj3N9Yuir8LOcyH
X-Iguazu-QSIG: v=2; s=0; t=1743086178; q=2yAbj3N9Yuir8LOcyH; m=PTqWhHYjUgB3wQ2JO9yVaVFqi+tc43zhXJh6KsxeIE8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 52REaHkv1617003
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 23:36:18 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4j9bQqQs9DjKA1+dtZjJl8WimHByyUUPrpPQ4UmUVibCzlbSCgbsm9omA9hMiDZd7meRiWKyGqrIIxEtPS/Y4giIj3gQd6lU49T9fkpsSNlK69y0iLSvJjFx5p79+XX1mGOJE7IyPyQBY+c5ULlMngG2oW84dsNYgbcz9oGlV6ZdhTMV9aG9WchMRZjzm2qqAP1z3X6u5DSeF7dM2O766TbfiVRJ4r7NFj85ylhFZDiQjpw0IpDEdZ+rv6hsGZwtct35ua3BsAjKFOWPXsyDC7VlCT5ix/4iEtE1zLzNA+A0QQ2wTiL7JA2zZowBL78S/0PLVbPFe4nezSYspf9zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMDdi+wRZQjbs4JzqySZC+FJNxZogRchowaL8e1I0ew=;
 b=NiDzIxEXSwABn8vfci7eiAahgeilHo2A5LXmKAFP0m4frcHcqJVPRoFMFGFobFJfhGheAE1apymEMcNLLQTR/0GgWDEPZj20K2eAqjZu1esxLsVPoF4lgtb0eTDgd3PjNt1MVWwNgAVNnVWReNzYBgvOzg5K2P+0hAl0W6C2K8qXOTJBHD1VdaB/Q2hgSzr0j+9Ai4cQY+KqZ2GmefPfu4F+jvY0UC3yxgsvYpVh2PBV+FoUPQmfiYKCJJ3tlzAoq/dOpuy7nk9TLUDFoOYPWV5SOaHqZNcYKVdfbcFbBu5lkThMZJOEM67ov3AoqzsVcnDjtyd17xDmEVXK3NiGcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <Sai.Sathujoda@toshiba-tsip.com>, <Adithya.Balakumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: RE: Request to update all LAVA workers
Thread-Topic: Request to update all LAVA workers
Thread-Index: Adue/RC0RLD0UqcOTASX222hFpAV5gAJL39gAADeIuA=
Date: Thu, 27 Mar 2025 14:36:15 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB11075E17A599DB6F0D4CEEDD9C7A12@TY3PR01MB11075.jpnprd01.prod.outlook.com>
References: 
 <TY3PR01MB110757C96225174319F00BA9AC7A12@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12@OS3PR01MB5896.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB5896A0BFFFA760FE2F5A8F15B7A12@OS3PR01MB5896.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|OS0PR01MB5716:EE_
x-ms-office365-filtering-correlation-id: 561d1096-eb6c-4f75-d23e-08dd6d3cba87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|8096899003|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?R0dpRmVzQ3JoQU9LUGtaL1NWRlY2L3FDZXRtL1ppcG05eHFvTHhxVDhO?=
 =?iso-2022-jp?B?aDQxWCtUb1FmR1BzMHVQZmdBU0JIQ1ZxK3g4dnpHYnc4Uzd4SGNYOSt0?=
 =?iso-2022-jp?B?ZWg2VzJOQXl4eS81ZHYyci94ZXR0ZVdsblJTWVllZit1dm9RTys0M3F4?=
 =?iso-2022-jp?B?TWE1SG5JZmxDQTN3b1h3U1pyYi9Bd2Zsa0Q3MlNhczExZDFVNHAvd3Zv?=
 =?iso-2022-jp?B?cWJrU09pRm9jQmJzZy9XK1ZobmtFcXFsRUprUWg5NmdoNDNqcE1DY3Nv?=
 =?iso-2022-jp?B?SkQ5T1VyWk9QS3ZDV0h0TWZQVERyZ3JKaXB3aWhwL2dTZ1pYd1FwdjAx?=
 =?iso-2022-jp?B?QmYwUTdvTkxWandGMWNzeXdtb1UwVGJ2UFNYY29qTHdkeW8zQnNOTjh4?=
 =?iso-2022-jp?B?RlR4VTlBcGFadmxHaG9DaHhETEJPWEhmSmtmQ3NXNU42cyt6dzh3dmxU?=
 =?iso-2022-jp?B?SVJtenJCUjc3NG9sa2dCM1JidUlEWTBGbzJXWVhFRGpCMWRJUUhDVE5J?=
 =?iso-2022-jp?B?d0l3aXY4QmZqeGxDYUc2b25NVE04aFRxelVDNjdYUXRtMW1teW8yT2pK?=
 =?iso-2022-jp?B?TjZpZGo5Sk0vOForenI4NlV2ODhkL0M5cFR4K3N0VjZRaVp0Rmh0K2xD?=
 =?iso-2022-jp?B?U1UrcWtYdGQ2STVoQmkyck9GcnZjOHlDWDBjRDZCTThJM1lWdnJPMWIz?=
 =?iso-2022-jp?B?YkF1b1V1cm1PbDNiamV5aEZVYzR0WHN5QURldjVGcHF1M0RmTzBRcVZ1?=
 =?iso-2022-jp?B?d3dCRkwvTUtiUER4VmZ3bXdORHVqa1g0M0lsb2I2UWJmN1N6Zko1VDJ5?=
 =?iso-2022-jp?B?T3ppNHRWdWJJV2NvQ3BlSWxHWVJtbGxuZGJ0MUJWOEdiWUJKS0trcC9q?=
 =?iso-2022-jp?B?TFJTV3MyMklXQ3ZnYUhlLzhTUmFvUDVORU5SbFUxaFppcHo4R2FmYW5X?=
 =?iso-2022-jp?B?WHg1aEI1RmFvR2Q3Rmx0L1pwcnFUdERyN3JTZ2Y3RHZiYTJLSENwVHpI?=
 =?iso-2022-jp?B?VTVucjRXMHIyUytQWXR3dllCajc5c216Ukt4cUJMTDcwMzZuNVMxM3Rh?=
 =?iso-2022-jp?B?bjZoVGR3bGYwSndueGhvYUtZUUozbHJqYjZPQVltOVRCbzVjV2l0WnNU?=
 =?iso-2022-jp?B?K2FidEFTbVZranRmL1g0ejJWOVhCZFYvSUpVTjRodFBVcWo3VVJTcHJ5?=
 =?iso-2022-jp?B?dzByeFVsV25KckcyYm9Wc3hjYytlYkhnUUJIUmNnQU5VZklOWk5Ialky?=
 =?iso-2022-jp?B?aXdVSndKTUZRcUdVSEpKcHYwT1RZRWdXc3owRXo1TVBBemsyblUyazdS?=
 =?iso-2022-jp?B?UUFkMUlLekpOeUlXUzBPcEJvSlJxRXk2T3VCYnVvREphSjdHcnN0aW5w?=
 =?iso-2022-jp?B?aW1vUDlFbVBlZVV1RVNEajRDWGl1TmM3L2JDUyt0S3czOWQ3Mi9qaGZt?=
 =?iso-2022-jp?B?TFd5SUwvU2JRK1ZVN3VPL0gwYTJaRE9HQXh5Nk12QWVIYTkwREZPbzZx?=
 =?iso-2022-jp?B?RjB6N2VlRWZzSzE0RUptOEpGMHh4Nzh5QU5XSkZhdStsdzlLYWg5bnNM?=
 =?iso-2022-jp?B?YzgwbFZSbFlidDNLZFZwSGpCVXRJVGt3dkVSMkVNTkVzcW1EQm8wc1J6?=
 =?iso-2022-jp?B?UEhmdE1GOE9wR05weFRWV2REd3NhK01EMXJRVUt3MDNPaHZpa2hTUjN3?=
 =?iso-2022-jp?B?MElGTjdqbWlkVVgvQVZxekg5c09rWFJHbXFyTG0xdmt5Q0hqczN1SHhE?=
 =?iso-2022-jp?B?OXJwa3czZ1p2NElFWkJLajBFUUk0emwxcFY3eDdXT0NObHJDSnByMWR3?=
 =?iso-2022-jp?B?M2EvbjZQWHZBc3VzMkxOUGI2MVBoWjJzYW41SU9vZ2daVjBxekpDSUxw?=
 =?iso-2022-jp?B?UGd6bGlWM0FWSk9wWlZmcGhxQjdzWjBXZi9WSU0zaExQRmlxb0kzblJU?=
 =?iso-2022-jp?B?b0pqOXYvUlF6N05FTzFhbnQwM1M0ekJoZTFLMXR6aTZyMytsMGhwMFFU?=
 =?iso-2022-jp?B?MFJUQWdUd0w5bmpBOXRsMFhJdDYxZzAyd3FhMU1UNlpOUDBnUlkxdEgy?=
 =?iso-2022-jp?B?a0E9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(8096899003)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SWE4UUZzQjNVVlFRaVd1WSthbGZvTFVIam5tekpXQ0Z3cXR3NzJpbGwv?=
 =?iso-2022-jp?B?cmo5UTlqd01LamlYTE9rNzdqdDE5ZmhlM01QNnFkZkhJV29EK2hMc1R1?=
 =?iso-2022-jp?B?SU14WXp5d3NyZVlFVmhPMU16Mi85d1E1My82dWh4L2lBZnpmY3VVN3Zp?=
 =?iso-2022-jp?B?d3lQeTRJMTZRZ2ppQ2RheGlqZHFYeHBtai9PUHVDMHhmS29wNTdkbGNu?=
 =?iso-2022-jp?B?WS9RcUx2QXhWWDhKNncyRDBHa0dxL2plbWM5dGczUWJKalNnOHlIcjRa?=
 =?iso-2022-jp?B?ZitQSEo1UnRKMjgxSk1ubFNDR2M1SGtOdEJxdHJwU2lUbEh4NXMwVVN5?=
 =?iso-2022-jp?B?Ly9lSTQzcTJ5TmFyRFAxV0ViYzBoUi9NMHpSdXBxL0pVWlhmTit0MWEx?=
 =?iso-2022-jp?B?ck5ydGFFRGxtK2ZYcHhoNnVmTE9iYTBuQWRsczFJVFhBNE94SGFFMkta?=
 =?iso-2022-jp?B?eFRkNWZ5S3M5dDdmTlJVaW10Vy9aM0lYelVnMld3Z2VtSWhXTEs5Tm40?=
 =?iso-2022-jp?B?c1F5VFI0UVRrUjQ2bk1zZHU3cndBbkNnczBvTjl0Q1dOQ3cxYXVnOGlJ?=
 =?iso-2022-jp?B?aTRpczRoblpHcGhIbmlLeTlZbTNlM09MR09QalFvMmtTYzE4NmFpRUpV?=
 =?iso-2022-jp?B?cUpaYUxJd0dWSHlacFVXNDRUQm5Ka0JNSTN4QUljVFRJZU5OdnpEZVFN?=
 =?iso-2022-jp?B?N1JTMVdXbWduNWcwQy9QR0tMK1N2T0ZBRGYzd01ZWHdkMG5MV1Bmbnpi?=
 =?iso-2022-jp?B?TkhWb3REVXUrUzFiaFV6YjFGYUM3Q3lOcmRZeEV4clNYYmYyaFE3aUts?=
 =?iso-2022-jp?B?UEFrMmtHdzZCSUhiTWJnazNBSEYwQzBqMU9lNTFqdWlrKy82TkhUdm9V?=
 =?iso-2022-jp?B?N3RNTnBpMUljQ2dmQ1REaytXZytvVy9HNUp2dUMrd3dyakJINEp2QTZa?=
 =?iso-2022-jp?B?YmJDbjNRL0p5eFRKMXhBOEdyeHNUTDQ4emJha09vNFVFSktmYS80RkRz?=
 =?iso-2022-jp?B?ZmVoQTJ2VFdoRDZ0anhIRnRSOXB3UlNPbjF1djFhZFIrdlR3a08xbVpE?=
 =?iso-2022-jp?B?UjhsR0FEUUVzTjBFRVlWSjBURGx5bnFRN3YzcnVRRUdqMUVOT0JjVGZ3?=
 =?iso-2022-jp?B?SVd3VjduZTNRSFpBazNkY0treS9WaVRXb1RsaUtpaWI1SmloOWk1b2Jm?=
 =?iso-2022-jp?B?bDQrQXpDUEMxRElHdGxOL0N4MTBQcUZjUGRwUU90YUI1WTBCTkVWQ0NQ?=
 =?iso-2022-jp?B?a2pWbDcyWE8yVmcrTU9UOXBEVFJxNGNUYjA3NFExWVRsVHZzU1hFZytn?=
 =?iso-2022-jp?B?WUcxSFBiMWVJeVFiLzduN1Nlc1gyTmE4NzB4Q0tkTHdLcXVkeXM2T0Zr?=
 =?iso-2022-jp?B?dmpxTXRkZ1FaVG4vN0ZXOEVhUEl5VmdXY2ZOUzhWUnkrMFdMdFNRclF0?=
 =?iso-2022-jp?B?Q1Z5UTNDMW1QblB4ang5NERDMTdFSUgzODREbitoTm9DaENPZ1VmcTJw?=
 =?iso-2022-jp?B?RTZtNmFyTmloWUJJUHlUZlVHMXluL2I2REZOdVJ5VzBuYzQ0aytFZ3F2?=
 =?iso-2022-jp?B?NlIyRllUUkNMb0RSUDY4VmZ0SXIzVHhKTUE5R214Z1daZ1dEcW1MdzRW?=
 =?iso-2022-jp?B?cUs5dkdZeU5NMXVZKzJ3Y0dhNXdiUkZJWnpieFpZZ3NpNjFsQ1A5bGVS?=
 =?iso-2022-jp?B?RmpqZmJDbGlDUG9uQ1ZVYmx5aDhwcjYrN0FkSWRTSEs5NHN6TS9yOHJV?=
 =?iso-2022-jp?B?aWh0RVdUY1RCNjA0V2ZPT0dxWDkveHNreGNabGNORjRuZ3c5NVlVWkFW?=
 =?iso-2022-jp?B?bUc4clh0U1hZTTBjNk5VbXRjVmRRYzRIVVNKTVlEdDJPRzcySFdtQjlR?=
 =?iso-2022-jp?B?Wlc5VTkzNXQzb3ZqS1pyMFJOM2RVZTF6ckVHd002U2dFTVdNbXdSeWFk?=
 =?iso-2022-jp?B?ZlBtdCtmQUhsVmtXeGJiVnJkM2lGN0s3UUpKL0dCSWN2MjI1RHRsdjFH?=
 =?iso-2022-jp?B?SGhmOHBKbXNVMVc1RjZ5WUoyUHNZejlFMGNkOVlaQkQxL0FVU2xwTXVp?=
 =?iso-2022-jp?B?d25LK3orcWlZQTM0TS90RnlaMmhydFU1OUY1UkxFQ2tpTE91Z29wZEI0?=
 =?iso-2022-jp?B?NTBKbU1Rbzd5WFdmK3RHdmlvQ1NNdHdSa0NNbDA2eWdrOGMxRllQKzJk?=
 =?iso-2022-jp?B?MjhMRmpHWDRhTWxibk9RbytidEQxZld0TnNRd3RkUEdtcmxvL29QaDd2?=
 =?iso-2022-jp?B?MlZqR0htZG44aHE5K0dUN2JrcFRXR1VDOEdmaEhOanRGTXYzNEZuRlZO?=
 =?iso-2022-jp?B?SGgzdzVWYkpiVVVLTzR0REFZeXRPS0ZFUUdNZ0Nrb0VTK3oxTnd4VmF3?=
 =?iso-2022-jp?B?bmxkUDg9?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB11075E17A599DB6F0D4CEEDD9C7A12TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561d1096-eb6c-4f75-d23e-08dd6d3cba87
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 14:36:15.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRkstwavvXvUVPGjW6q+aEBNLYG89u2QQk7uAKVTO72m7eB+sPmLnKpAqBaByFIRRouxrqNCR14MEHiBFbU86rjae0crEUShD4JTVkygltgDpTLCcxBZsbC0bKAbm+NM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5716
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 14:36:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18379

--_000_TY3PR01MB11075E17A599DB6F0D4CEEDD9C7A12TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Thank you for your quick reply.


  *   Apologies, I forgot to get this done.
  *   I=1B$B!G=1B(Bll make the request now and let you know once all is sor=
ted.

Sure, no issues. I will wait for your email.

Thanks & regards
Shivanand K
From: Chris Paterson <Chris.Paterson2@renesas.com>
Sent: 27 March 2025 19:40
To: kunijadar shivanand(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Shivanand.Kunijad=
ar@toshiba-tsip.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <dinesh.kumar@toshiba-tsi=
p.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B=
!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; ashrith s=
ai(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Sai.Sathujoda@toshiba-tsip.com>; balak=
umar adithya(=1B$B#T#S#I#P=1B(B DITC_DIT-OST) <Adithya.Balakumar@toshiba-ts=
ip.com>; cip-dev@lists.cip-project.org
Subject: RE: Request to update all LAVA workers

Hello Shivanand,

Apologies, I forgot to get this done.
I=1B$B!G=1B(Bll make the request now and let you know once all is sorted.

Kind regards, Chris

From: Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshi=
ba-tsip.com> <Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijad=
ar@toshiba-tsip.com>>
Sent: 27 March 2025 11:06
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ka=
zuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp>; Sai.=
Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>; Adithya.=
Balakumar@toshiba-tsip.com<mailto:Adithya.Balakumar@toshiba-tsip.com>; cip-=
dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>
Subject: Request to update all LAVA workers

Hello Chris,

Recently you have merged a patch in lava-docker repository https://gitlab.c=
om/cip-project/cip-testing/lava-docker/-/merge_requests/44
You also mentioned we need to wait until all the lava workers get this upda=
te. I checked today, it seems this change is not reflected to any lava work=
ers.

I need the above change in all LAVA workers as some testing is dependent on=
 this change. I can=1B$B!G=1B(Bt send the patch to isar-cip-core repository=
 until lava workers get this change.

Could you please check/request other LAVA maintainers to take this update?

Thanks & Regards
Shivanand K

--_000_TY3PR01MB11075E17A599DB6F0D4CEEDD9C7A12TY3PR01MB11075jp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:EN-US;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:25303056;
	mso-list-type:hybrid;
	mso-list-template-ids:-1574648000 -1323939834 1074331651 1074331653 107433=
1649 1074331651 1074331653 1074331649 1074331651 1074331653;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:\F0D8;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;
	mso-fareast-font-family:Aptos;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Wingdings;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-IN" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thank you for your quick reply.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ul style=3D"margin-top:0cm" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"color:#7030A0;margin-left:0cm;mso-l=
ist:l0 level1 lfo1">
<span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif">A=
pologies, I forgot to get this done.<o:p></o:p></span></li><li class=3D"Mso=
ListParagraph" style=3D"color:#7030A0;margin-left:0cm;mso-list:l0 level1 lf=
o1">
<span lang=3D"EN-GB" style=3D"font-family:&quot;Calibri&quot;,sans-serif">I=
=1B$B!G=1B(Bll make the request now and let you know once all is sorted.<o:=
p></o:p></span></li></ul>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sure, no issues. I will wait for your email. <o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA"> Chris Paterson
 &lt;Chris.Paterson2@renesas.com&gt; <br>
<b>Sent:</b> 27 March 2025 19:40<br>
<b>To:</b> kunijadar shivanand(</span><span lang=3D"JA" style=3D"font-famil=
y:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language=
:JA">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA"> DI=
TC_DIT-OST)
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA"> DITC_DI=
T-OST)
 &lt;dinesh.kumar@toshiba-tsip.com&gt;; hayashi kazuhiro(</span><span lang=
=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligature=
s:none;mso-fareast-language:JA">=1B$BNS=1B(B</span><span lang=3D"JA" style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$BOB9(=1B(B</span><span=
 lang=3D"JA" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatu=
res:none;mso-fareast-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#D#M#E=1B(B</span><sp=
an lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:JA"> =1B$B!{=1B(B</span><span lang=3D"JA=
" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none=
;mso-fareast-language:JA">=1B$B#D#I#G=1B(B</span><span lang=3D"EN-US" style=
=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-farea=
st-language:JA">=1B$B""=1B(B</span><span lang=3D"JA" style=3D"font-family:&=
quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA=
">=1B$B#M#P#S=1B(B</span><span lang=3D"EN-US" style=3D"font-family:&quot;Ca=
libri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B!{=
=1B(B</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,s=
ans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#M#P#4=1B(B</spa=
n><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:JA">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; ashrith sai(</span><span lang=3D"=
JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:no=
ne;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span lang=3D"EN-US" s=
tyle=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none;mso-f=
areast-language:JA">
 DITC_DIT-OST) &lt;Sai.Sathujoda@toshiba-tsip.com&gt;; balakumar adithya(</=
span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-ser=
if;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><sp=
an lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:JA">
 DITC_DIT-OST) &lt;Adithya.Balakumar@toshiba-tsip.com&gt;; cip-dev@lists.ci=
p-project.org<br>
<b>Subject:</b> RE: Request to update all LAVA workers<o:p></o:p></span></p=
>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">Hello Shivanand,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">Apologies, I forgot to get this done.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0">I=1B$B!G=1B(Bll make the request now an=
d let you know once all is sorted.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Cali=
bri&quot;,sans-serif;color:#7030A0"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0cm 0cm 0cm =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US" style=3D"font-family:&quot;C=
alibri&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">From:</=
span></b><span lang=3D"EN-US" style=3D"font-family:&quot;Calibri&quot;,sans=
-serif;mso-ligatures:none;mso-fareast-language:JA">
<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com">Shivanand.Kunijadar=
@toshiba-tsip.com</a> &lt;<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsi=
p.com">Shivanand.Kunijadar@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> 27 March 2025 11:06<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@to=
shiba-tsip.com</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a>;
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a>;
<a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com">Adithya.Balakumar@tos=
hiba-tsip.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a><br>
<b>Subject:</b> Request to update all LAVA workers<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Hello Chris, <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Recently you have merged a patch in lava-docker repo=
sitory <a href=3D"https://gitlab.com/cip-project/cip-testing/lava-docker/-/=
merge_requests/44">
https://gitlab.com/cip-project/cip-testing/lava-docker/-/merge_requests/44<=
/a> <o:p>
</o:p></p>
<p class=3D"MsoNormal">You also mentioned we need to wait until all the lav=
a workers get this update. I checked today, it seems this change is not ref=
lected to any lava workers.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I need the above change in all LAVA workers as some =
testing is dependent on this change. I can=1B$B!G=1B(Bt send the patch to i=
sar-cip-core repository until lava workers get this change.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Could you please check/request other LAVA maintainer=
s to take this update?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shivanand K<o:p></o:p></p>
</div>
</div>
</body>
</html>

--_000_TY3PR01MB11075E17A599DB6F0D4CEEDD9C7A12TY3PR01MB11075jp_--


