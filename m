Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C36C3600B
	for <webhook@archiver.kernel.org>; Thu, 27 Mar 2025 11:05:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.47282.1743073542741963049
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Mar 2025 04:05:43 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52RB5e7i3139119; Thu, 27 Mar 2025 20:05:41 +0900
X-Iguazu-Qid: 2yAbpfLvGX6X2QdBlD
X-Iguazu-QSIG: v=2; s=0; t=1743073540; q=2yAbpfLvGX6X2QdBlD; m=+hGtnUQNU5IJ/IoxVFtGhwe8GekqXjZVV1VvfQ2heO8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 52RB5duG288159
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 20:05:40 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIN5RAPZ67Le9iU2MvPvLYrVKUbknvYN7rKsthILDKuRun49AxlEo0ekD5PrhvT1N1AtuEVvEX0u2nawSRQ5qokCSi7RmJvkSOmDVC3LzfsaXOuCRAU2uBlqwOzVUHX2xtu0xZtF9E3EZkaPQZT5zXv4yyaQb+q+4bzUUMZe1MLWe4zmpBevR/BW+qa7xh/2KN8F+kZpSNedy7t8nkfzd7GMe1Ixb+7xDMmpu/Wu4kkBUaqGxoSo51jfBJiwKKbQDRVk9rbrf2uXhHRZqQ9J2ejKxLSyvVWEkzWi1SPS5h+H/S5FxoU5BiDbfOsHKaKTq9T9a64m3aJy0uiWM/7vmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V+8elQQmuzdwbl4g1jXwm8hRidgTfIunuJg82e4S1c=;
 b=afmufvhU3C1IO1NxfO4PW4dquaIt2L290sC2VGff2Ux9i6jfPI+t9lNmJM6c7RACPCYzDReSBU02YYvjd1oMCC6WH/w6O8905FacrGklURDG90oTagUe6hNmfcDWcCqpsHLeSXGq065z79Dl/j7Up/YSpUpsUQhbBVmCfMqP2O0JwtSkTtoQdV7QVAJeXTkz6rEOuKJaZPM4fFbT29PD8eCiI6oWmd83LgBU9cJqIZJV49yJFFf+lj9akM4hdY0OXpafddv+5ZCBUlM4bJDIwFOsyXXSVRH687UlxVjdfTqaGGt7tNbBbs1Erxg8uO20AURcNww0xUAQJjxPdfY1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shivanand.Kunijadar@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <Sai.Sathujoda@toshiba-tsip.com>, <Adithya.Balakumar@toshiba-tsip.com>,
        <cip-dev@lists.cip-project.org>
Subject: Request to update all LAVA workers
Thread-Topic: Request to update all LAVA workers
Thread-Index: Adue/RC0RLD0UqcOTASX222hFpAV5g==
Date: Thu, 27 Mar 2025 11:05:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY3PR01MB110757C96225174319F00BA9AC7A12@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11075:EE_|TYCPR01MB8899:EE_
x-ms-office365-filtering-correlation-id: ad10b1cd-61b1-4358-3bac-08dd6d1f4e05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|13003099007|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?Vml0cVJYZXhJZE45OEIvK1hQeGU2WlFLc0MzeFRzSUtRU2ZlV0t1RlFq?=
 =?iso-2022-jp?B?UmZCbnM1KzIya1Ewb1h5VDk2WlU0NlhBYzJnZ2VuZWFqWDVSQ2VmSVlo?=
 =?iso-2022-jp?B?VndmdmJudHdnaGtZZjBQKzZ1djJGV25iT2s4V3FPZXpqdEFodm5sWitG?=
 =?iso-2022-jp?B?cEN1M1RnWURvdVpMUEljVHZiU1JTSW84VDNkNE5JRWc1cklIZjJkOGda?=
 =?iso-2022-jp?B?RVZZeFExNkRidmIxQXNlUkNENWZjVmZONy9vQUlSTDNxOTNOYUR0Szlz?=
 =?iso-2022-jp?B?WnFINmRXWjN5N3ptNnZENkQ0SU9aMDB6NVBCdUkzYlJhQk01TFdneWVt?=
 =?iso-2022-jp?B?RFVFbmMvdVh5SHN2UFpVeTZSU2xjVVE1NEd6YU9RTUx3VVZPSGV0T3dj?=
 =?iso-2022-jp?B?QVpJVXNkMjB2VnN4Z3lMMy9xK2RkS1RTTFlpK2ZxeUtINmV1VU4yQ29K?=
 =?iso-2022-jp?B?Ky9obG54TFVVajhublVJMWx3Q0FINndBVEdsUWgzeTZudGR2aFNodU9h?=
 =?iso-2022-jp?B?dXlyVHdiRldkS1d1OFloYTVZbDFCaUtPUWgrUFh0VWIxdGxldUVPck95?=
 =?iso-2022-jp?B?elZTc2N4Ukk2S0F0Z2p5WE9mZTE4ckx0RW9MOU5QNkxRd2ZkN1hHVTQ1?=
 =?iso-2022-jp?B?SnU4d2o2YzNMcjVTYTRYek9rbk4xSUVTNzk2OUxCNVVWcUJ0WGEydDE1?=
 =?iso-2022-jp?B?MUtJUlV3NURodmlsVm5SVzN5bnk1cU1NamxnelBic1JzMW04bUFIRndk?=
 =?iso-2022-jp?B?dFhFeE5zUWh6ZFEzekdrZEZXUmUydjF5R0syNjViclVFWDM0UXZjNktw?=
 =?iso-2022-jp?B?WDhsVms0RDVLL1psYTBiWTRqN0lEMmNrZ3FyZURRL2YrNGFFUVcyVnJP?=
 =?iso-2022-jp?B?Rmx1NUQzL1EvQjNUa2FTTzRMZ3krZXBMRXc5MGhwNnd2S0xPb1pubkZp?=
 =?iso-2022-jp?B?b1lXQUJVNEFWbmpodk0xRjBsMjNBRDNKazlXSS9LeDF1K0RqcGQyU2xV?=
 =?iso-2022-jp?B?UmNJZVAvdUw0Rzk0Z1hINmhZYjA3SDdLMjdEV2UxRjRrMmtkcE9VcXVr?=
 =?iso-2022-jp?B?ZzZFR3VpZGpRNHVzNCtiM2JhMHVNaS9sUVBmRTBGVUlPS0RzTDBZZW5D?=
 =?iso-2022-jp?B?QlRsYkQ2SHlYS1FheVZJOFdXY2NHeHF3ZFdnQ3g3ekJ2TVBBRHcyejhy?=
 =?iso-2022-jp?B?VVNycmkrK2w3bisyY1NoREVBS2YvZVdETzJGWjRQRldnV0N5TWR0ZUFy?=
 =?iso-2022-jp?B?dEZycjJ1YnhZamFxUTFzdDR6QTN6dFRWWW9qUDhTS3Rnd2hvc2haWHJX?=
 =?iso-2022-jp?B?TnkzaHpvenRoMmVHSGMrZWhwRzUyd3pydmp3Rkc1K1dsbjZTN2Vlb3FM?=
 =?iso-2022-jp?B?RHpqZ2ZDL1Y3UjNWajhwdzE2Wmtydkh2T0hlL3djY1VjNGNUNXVIRGZS?=
 =?iso-2022-jp?B?VGJxV3V0L1VURDBqZy8rblZQM1BmUFluREQ2dlRYME1vOWp1eFU1RjJH?=
 =?iso-2022-jp?B?UW5WbzlIbEkrZFZ1RGN4MkpHdkRpVEtRODJjVURXVTBLenFwWlZLRVRv?=
 =?iso-2022-jp?B?WVc1TDBaU205ckFvVWJGbGpYS3JadmVVK3hXOHB4V09VQjI1aXlreGtv?=
 =?iso-2022-jp?B?amlwcjNMRFhPQ055cWtSZlNjTlV0dC80NWhvak1lOGFycG9HNTZUb0Iv?=
 =?iso-2022-jp?B?cmU5ekdZS3FUQ0JuZkpXVU1jcjRjbjcwbDZRQWRmWnVKc1JBbG16cHVO?=
 =?iso-2022-jp?B?OXVhVHVkSGpvck5tTit6cDN6VXJtamRSNWVwSmJEYTl4MlpONGlZUC9l?=
 =?iso-2022-jp?B?TzluNDJmbVhrQ0Ztdlg2blphNkRwd2lhbzVyL3lQOXJ4YXpMN1FpN2Ur?=
 =?iso-2022-jp?B?QlQ2Mk9FRU82OGpaUjhBRnpzL3JSRmZKZjhmWHhkNzN6cHJRekUyNUs0?=
 =?iso-2022-jp?B?VlJYMXM5VWhnZlFLRlp2aDZOYUdTdDNUS1NIck5zQTJuRitEclVxblBV?=
 =?iso-2022-jp?B?YmYrcVY3RStIdXdDQ2VUajFCVHhCZEVOZENQU2g2Vmc5blVCNE41dWRx?=
 =?iso-2022-jp?B?dEE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11075.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(13003099007)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UHRMME1RNHpiNVdqM1dWUGcybEtmaTl1VEM1YWpTTGJRWU1mY2UxREJJ?=
 =?iso-2022-jp?B?M2txV0p5TW5nM2JkeEdJTDI4d3FCdG02eVFuMXVpempZaHJmaEwybUpQ?=
 =?iso-2022-jp?B?R3NyWUNZMjh1azNHSHhBWERqc0tKMm1VckJzWG52WEhGNkVRVXNuRkRm?=
 =?iso-2022-jp?B?QzhkcTBTWktPbUtRUUJKZUZ0cjV5Q3NQUHZuRXdQWEtEcTFzWEttNEla?=
 =?iso-2022-jp?B?QjZkZGRXVHdpeVFrcVM5aGZQaUUzekRabFU2QlBFclpUcUFWZ2IrNUY5?=
 =?iso-2022-jp?B?T2wxVGx1YTJtZU1vMU5ldWhxTTQxd05YSzdNUzRpMEZUTXpOMHh0bzlN?=
 =?iso-2022-jp?B?K3JxKzhQSlh5Qm5kd05XRkdzZzNGMmFUNmg0dVRoRlFKS3p2R25TOVpU?=
 =?iso-2022-jp?B?WkZsL3Vwb2dZV3IwTk1HbGRKem5sWXhxTk1tbXZqZERpZ2xmRUZvclJI?=
 =?iso-2022-jp?B?ZWRXek14U1M5MHQ0WWVYKzEyL253OUJqbXMvMTRWaUk5cHhZZXNVdEU3?=
 =?iso-2022-jp?B?dDJKQjZCTXlFTDNvWnB3YlJpaThhd1ZYL3ZlNjZDbFZpQld3bXNTdHFN?=
 =?iso-2022-jp?B?bWdMd0hzZTc0eTZ5Qk92Mkc4bmtaSWMvYlhZamhxVHZ3azdtSDdPbGha?=
 =?iso-2022-jp?B?M1ZXazJaMFRzbjNheXlGQSt1MFlWNDhWc3RnR1gyek5YNjlOQVdGYmIr?=
 =?iso-2022-jp?B?RTRUVWkvQWQzbFJYeDI4cndTR0ptaTc1SUhnZCtpbGFsQ3dWTzBVY3B3?=
 =?iso-2022-jp?B?YkgxYzNWYXZ4aWxKSzltWmE5RHJUN0phK2dLZGd1eDdOSzlJdUI5WjJL?=
 =?iso-2022-jp?B?V3lqMnVwdlVwY3IzeXBvR3hYUWU0Mnp2RnZsMGdsNTZQeW5xOCtWKzRr?=
 =?iso-2022-jp?B?bzZLazBKUmhRWGJrVzlxMFJhekRUNEVKYnZDd05ZY0MzQXRrWSt4SXZP?=
 =?iso-2022-jp?B?V040VkVVbDZQa1NVWVJHTG5mc21JRmNVbi9weHR3SE9YbDZNNE03RHVl?=
 =?iso-2022-jp?B?aFBVc2l6MklFYmxpbTQ4MFFja0NnZXhkS3dJWVI1bDVwbnJzSUkwRlpK?=
 =?iso-2022-jp?B?MmhxUkh1amNhRU96alc0SjJtWjZDOVQ2Q0N0TEswZmRGU0IzWEpCRmM0?=
 =?iso-2022-jp?B?ejB2ckgxU21iOWNsVDBnYldWeXRGUVRMNjk4a3RPOHdVZ0tqRWJmT04r?=
 =?iso-2022-jp?B?YXdubDZNZWlPV0FpcnBvamhjdU1GcVlZV2hmajF4bC9Kc0tsdlh1eG92?=
 =?iso-2022-jp?B?eWNXcEtmY3ZwK2tlWFZ6N3JOTlZXSHVYLys3OFV2VWJic2d3U2hmTHEy?=
 =?iso-2022-jp?B?bTZJSDVPUWdXS21adlFsSWcvVEhITDJNMitiNmlIeWd4aUJTT1MzZnpX?=
 =?iso-2022-jp?B?Y0dtQVFXbW1kVUsvOHI3TE5naG4rTVVBWHdKaldLSjRHZ25ic0gzcWJa?=
 =?iso-2022-jp?B?QkdhZ2RLdFh2djREYmt2bThVdXo4VHozWXdydjdpd0hnVjhZbjh5MWRN?=
 =?iso-2022-jp?B?MHArdnk4NXk0YndzTllNNVdNUXd4NEN6WXMwSVp0VjhPU0ppWkZmS0NP?=
 =?iso-2022-jp?B?S3hCNWRNZUhVd21wU0pKMDlDUExpVktBSURJSmtyQ0hCZEdNTkVhL3ZR?=
 =?iso-2022-jp?B?cEpEUFBCY2JhRDlKYmtjZzY0MFRUUFR5V0pLc3AzUHQ5aXViTEtGT1Rs?=
 =?iso-2022-jp?B?YnZOa0s2TTlrNzM3a0YwdXcrYjZyVTFKRzRrNXVSUjVUVmViNmhPM1JN?=
 =?iso-2022-jp?B?SEtuM1p2Z3Q4T01ZZDhWQUFURldVYjc1SzVYM0VHbzdWRzZDT0ttVjBx?=
 =?iso-2022-jp?B?cEpLbG92RGV3R0ZxSlJJYklHT0xZdW9IRHI2NGh0MXRQOExnaXVzbVFQ?=
 =?iso-2022-jp?B?eCs5bUordnFhWEo4ZGVubnlXQnFadXNNb0FkSGMxbThWRE40dWNDbTJm?=
 =?iso-2022-jp?B?b2MwZXNlaGFWcmVKT1NMaklsaUhwM2RyVXdIcHQ5eDNmaWVXQlcxd1Jw?=
 =?iso-2022-jp?B?NUlRRzVUempPQ2pzVHVNS1ZSYXhkRWI3TytLVHZ1d3JESzBpcUhEWlN2?=
 =?iso-2022-jp?B?YWRub2c1Z3FGNUNBRElwZWdpVWxKeHBqZTd4L0p5dUp5Z0JKMXd2NzIv?=
 =?iso-2022-jp?B?Z3JTMVBWWlRIWHRlNWxDclpDOXhoVGpqVm1GTjlCYTk2eXBHUlJkMmtY?=
 =?iso-2022-jp?B?dHdqL2pkMENQcVl3NFdvcFZvUkt5LzBmWGxjdDVoZlFORmpCSjRPU1Rw?=
 =?iso-2022-jp?B?SENRNWFuOXlzeFJxQ3VuV29rYis4N0V6Q0JoR0FHbzJhQm9KWlQ4WGti?=
 =?iso-2022-jp?B?WjNWbWp0cHZLbDhPY2ZacnJEeUw5bEFkRGxheUVJKzJuSTh0eTBHLzQw?=
 =?iso-2022-jp?B?dlRPeHR5dTNEWXpwUnIwUnVlb1pQNVZNSnZYM2J0YVViSzZpL1BPSy9E?=
 =?iso-2022-jp?B?UVNnVGNhS3RSd0JldS9MSVFTdzJWQkRaYy93PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TY3PR01MB110757C96225174319F00BA9AC7A12TY3PR01MB11075jp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11075.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad10b1cd-61b1-4358-3bac-08dd6d1f4e05
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2025 11:05:37.6638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hdcl66ApMw08DhiOW05skqsLDo4o9r+lfGHrp7n1NJ/g3Vs1GRgUfZ5estxPHNvd+n4npGV/9sUDyX1+MZqJjnaei3wU40FEhArjABH1tSP09HIMa7/zLR9jFZ7oAVuc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8899
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Mar 2025 11:05:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18375

--_000_TY3PR01MB110757C96225174319F00BA9AC7A12TY3PR01MB11075jp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

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

--_000_TY3PR01MB110757C96225174319F00BA9AC7A12TY3PR01MB11075jp_
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
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
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
</body>
</html>

--_000_TY3PR01MB110757C96225174319F00BA9AC7A12TY3PR01MB11075jp_--


