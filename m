Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67EFC30653
	for <webhook@archiver.kernel.org>; Tue, 25 Jun 2024 09:06:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.167413.1719306403982551726
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Jun 2024 02:06:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=de3LVV22;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1719306393;x=1720515993;bh=RM8SDr4qqcfeuFf+EA1GDz//e8hTrAr4F9L34SV
	iu14=;b=de3LVV227JT5BhPo6/NmUFR9X+zVE+6/GLYcXHo77gxXAMwumejnl/LqH/rzB7SSMQ8tu
	rlGQSCj3fu0Snhvn55aJVBK+ilB56ptJEIwAUVvzQyWW61WTHcPVQjCrQ1rmSbOshhxlufO6cChu4
	fm/SblJoxmSy3MykcQtSF1tzqHOJXxPoCXaeSPo9IPU49xV3u/YhXWZ0JYASZFqBWzbh51GPaIugm
	XiN5lhCz2sqTNJXCSj17TDVcseQfZjG33lJ2fsJWz3ZkyfEPHHjq8XrcYZ4OYm71x6nJKqKYZ9ZR2
	sESIU5CGpO96L7Tk7gXw8v3WlLITPs4XzanYqJlZhQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 45P96XKB4074643; Tue, 25 Jun 2024 18:06:33 +0900
X-Iguazu-Qid: 2rWhnhX0cdRTgDWtzF
X-Iguazu-QSIG: v=2; s=0; t=1719306393; q=2rWhnhX0cdRTgDWtzF; m=LOQSNOKDqglx9qQdphyz6XuIT9bckV2qoKNu8Ikmk6I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 45P96WKR978201
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 18:06:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lI7c/B1sXjucN4jSIOo8Yvnx+ANmiBl2yN24MSw7fj/3HcI6ce/aCccKjxea7KDpdJ8bwdfun7V2THI1kpLgFLosOwLvvsZJIlB/mC3rXcLT/fNoNphxM9/coAS34uL3yLqnE+ES6WML+yN4N0qFom4JypdS6S5Lt6FAtMo6Y2zNNoWz0n3TrPXI8JS//oorIqqHUSwz4j1kz7rvCGbp6eyqSUpSwUOCCOikhxfm2CnMoWC8Om/5FqC7tSW7NYRpZL7oGtakkDyJQiAYaj6MSfQSGQLZ2UDhg4TTNZ9n1AciQpBFbxk/BIK01iXK3DRPGGZNU+VHmi/7LYTJsUsL5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x2ZLLDokaBZv92DTUvCFVnkIb5digZlPhwcITc4vaM=;
 b=Dzl0dZmMSLNZakhiIngL/prQAxQWaOMcr4EaihK/wEqr0HAZRymaGgP4W98Fgc87Q6if6HfNnTJo7RJuvcTqk5KPP/Qo9P/UXcE1XiVo8Mvvq2cg3ypKkHnhwf/4q0MG5rG0hhaZVXQa7cM/l81HMpNrPV3Vajmsg8fQ/s190971e94EvTHpd2rlDOcY6sW0tBSUb8EI80tQF45Q4r0VaWfM4hYIowqPmRbDtEJH1uTut93ICZHfpSSOtOnuGDz4UHIrss6rHqN7ypiNoKipW30GoMASlKtXFZyfK1iuGBE6nMVfrqTlp7bbBzEmbzL1SKDO4F+Adw8bwxHoQc7MHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>
Subject: RE: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the
 atomic flag
Thread-Topic: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the
 atomic flag
Thread-Index: AQHaw35zl+OnjM8pakWfH6VQDbIbMbHRx72AgAZu9PA=
Date: Tue, 25 Jun 2024 09:06:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388F0AF482706B3E1655D4292D52@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <1718935080-25727-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <TY3PR01MB11346BC663CF26EE6E197A05086C92@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY3PR01MB11346BC663CF26EE6E197A05086C92@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYTPR01MB10991:EE_
x-ms-office365-filtering-correlation-id: 1a545425-ae4a-4a65-10ff-08dc94f61a04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230037|376011|366013|1800799021|38070700015|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?dU9xUWdBZk15SW1wSFcvY2o3Q1l2dUovMlY0MjhSbEI1YzZWdGdSdzRZ?=
 =?iso-2022-jp?B?SEFlTHdLM0NtQVZkc1JRQXVJTkF1SmYzQWpuSkdoak9pOHdyekNSTjJB?=
 =?iso-2022-jp?B?cVNDOVpGaFhwVE15N3FicVVzK0hsMmZLQ0RSdWVLdkVHZitDMlRxdGdK?=
 =?iso-2022-jp?B?QkEydlViTHlFY2gxaWkzck5mVGRoVzN0NFRnY0MzOTI5ZlNQclhNQnVK?=
 =?iso-2022-jp?B?Qlo2K20vRjdvZDdFM3F2SUVNZjJoL0NwSHVyVDg3eUQ3YVRvRm4vR3o3?=
 =?iso-2022-jp?B?SUZvVGVpQ1RSYUQvUHhBS2dTZlRZRU1iQXA3RkRvb1hNYVp5eXdVREU1?=
 =?iso-2022-jp?B?RkRtVUVRRGxHckd2QzI2QUVYUFoyOWhyYjBwL0lkSDc3SU1GenFCR2Zm?=
 =?iso-2022-jp?B?SDVadkZ6SlhUM3JNUEVNNk1sS0pkVDIvWGhsYWhhUm9XanVOdGxLLzZO?=
 =?iso-2022-jp?B?UmtwVzUyVEk3YThZQTZ5cDJqZUhzWTNlbmlwU2dUdVZha2NJaEJhZHBk?=
 =?iso-2022-jp?B?QVFPNVZSMkZMSElrMk11bGErd2JVVnhwck54eW9Cak5uOHZLMmhrWmJT?=
 =?iso-2022-jp?B?V3IrNHdhMjBOVzVMTkVaQVdQZDY2dWYxbHc3Y3c3MkprMWRZYlBsd1lv?=
 =?iso-2022-jp?B?djh0alRrdkx3MFpudmhzSEJsV1FONDliWlFxYWpjVm1RZmJ6TFN1ajVN?=
 =?iso-2022-jp?B?RGNDRGJVSE5VYWllVjRyaTFrMjVHL2RxelZGaGtzZUJEZ3RiMkNWem1k?=
 =?iso-2022-jp?B?RHV1azVjYm1JbWo4dlM2ZWpHU21kOWlmUGRDckw5N2htWUl5a1pHQjIr?=
 =?iso-2022-jp?B?eEpMK3RZdUxKdDNuVGFsOEkvaXR5ME5TSEZXdnBqMld6cEJGU09ReGRV?=
 =?iso-2022-jp?B?SE9NS2Qzb0Ntb2hiUVdrS0tZMjdTSDJKWWJpTVFydlg4ODAwUW1MbmlM?=
 =?iso-2022-jp?B?RVYvN2x2QmU1cEhlQjNSKzhOYzI1SEliQWlOMkRENDhyQjRibGxXSWw1?=
 =?iso-2022-jp?B?blRFM3g5anlYOVpoaXFodFJrbkZ1cGVwYUtsc0RwZ3NGSEdWbDVKdTVR?=
 =?iso-2022-jp?B?dEd0REZ4dDRGTU9JNUs1WjE2SjUwUkJTVDF4c1EweGcrdWM0SEhGT3pH?=
 =?iso-2022-jp?B?TGFRTXRadVdtQzgvL2kxVkhMaytYdm41Smh6VEUxMVM2WW5peis5SEpR?=
 =?iso-2022-jp?B?dEhQb1dQOHlvZ2E4cFdVYi9QQlpvTGhSbEExMnVEeW1RMjB0TFdjNlVS?=
 =?iso-2022-jp?B?YnZFWjl1elc3NlJKUVR0TDNoUjdUUkRvZ2hoQkJ3UzFjcmR1dEZCd2lK?=
 =?iso-2022-jp?B?Ym55cGtXTExRTUEzalBQZ3g5d1YzUUJMaWdTbDF6bWFKU2tVQ3FPRWZB?=
 =?iso-2022-jp?B?NlBKWHQ1TTFXWFFrR3dqcTJ5RndNbTBxTlgydFNkbzZZQURlRmRXdmhi?=
 =?iso-2022-jp?B?d2poRGNBMWlKNXlaY2NpbUxEQlBRcTBNYkRJTSs3YTBVdWdwMVZjZXdq?=
 =?iso-2022-jp?B?VmRCNlR4NnJ0MmZUQ2dxMHU0TVdBL3hEVXRia2hEd2xENUFGeU0xakg4?=
 =?iso-2022-jp?B?TUFqMGtaTDFLTGlHUUp1UnVjeHA2T241RUdDM0h3Zk5XOFZ2WDJOaTYy?=
 =?iso-2022-jp?B?d3k5RmtFcG9VT1NkaG15TDh1U1FhUmJkQnFGWlY2QmlQOGdWZThkeFdO?=
 =?iso-2022-jp?B?R0U5Qm5Ub0wra0luZnlncTFJUjRFZlBzMyszd1U3N3AxRVQ4VHA2bENk?=
 =?iso-2022-jp?B?SFVyMVFya3hCeU1Yb2hKMUJodTU0QUNvbUVJei9zTU84dGtld2E1VGFi?=
 =?iso-2022-jp?B?QWp4M2JlaE9uekFzdkw5V3lpNk1DNTltaXpIaXpDUkI1aHA0ejBiRnBU?=
 =?iso-2022-jp?B?QXpaZFJaMVJiNDc1a202QVVMRk9CRko4cVRQZkhYcHZHY2puTmFWVVp5?=
 =?iso-2022-jp?B?Z2x0cVBCQVpTcTh3cjVKc1BQR00vY1dsL3BId1AzM0hHa3FSQUJNdEQz?=
 =?iso-2022-jp?B?az0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZUNqbEx5QWVrY0FxM1E1cFl1SEVhVmFaRDVPODVzR2JWdzJ0WGQ4SFVD?=
 =?iso-2022-jp?B?cEtxeSsxL3UzRXBBUHBjTDNySVgrZ1RSSThNUTNTdkx0REptU3pSM2RT?=
 =?iso-2022-jp?B?STRrNFV4QXloUW5DdUdEQnIxYTdiQ2d0cVlkUFM0SFhWR2tPcEkwMDZk?=
 =?iso-2022-jp?B?SnFaK1E0YWdDUWpZSUdCRkVUVVk2T2RNZ3h1M2JobGZrL29Yb29NSlF0?=
 =?iso-2022-jp?B?a2hYM3hNcFBWSmhacXNoMXh0R1V6RkdNMlBVQzJDUnlKcG9kYlNCaTc3?=
 =?iso-2022-jp?B?MndoTE5xQzlDMWhqb0NudURDUjdjNG9LQ1liNkpyTU56bmpSUkgvQ3c3?=
 =?iso-2022-jp?B?bm9LNXZTRDZNSHBVWWRwd0ROVjYzSEJaSHFvSm1VclVPa3FSVGE5WnJS?=
 =?iso-2022-jp?B?K21qbHQweWVnbVdrb1d3UEcvT0NvaXpTYkttWDI0WmR3T082Zm15UlZh?=
 =?iso-2022-jp?B?SVhwTGkvWXl4U1F3KzJYQ0wwZGJPM0xJVVhWei9hY3hxNTc4V1ZZbUcz?=
 =?iso-2022-jp?B?YzRaUGswdmRLdWZjT0hoT250QWRpY1hSUHhoWnhiaFlGNlBjK1pSTG0z?=
 =?iso-2022-jp?B?ejJ2UDUwSGMzR1VVeWtEejFkZFpSK05DS2hOeTJBcDhKU21pK2tQSVJW?=
 =?iso-2022-jp?B?dUdtZmcrWUY4UDhqNEhOamhweGdNaG1ldnBkbTRWcFE1NUtrdlRRSjNS?=
 =?iso-2022-jp?B?aVNOakJ2WVRGb0RnZytsQzJPeTZ3WGVWMFVmRTdwUWl0Y0JmUURtcTJQ?=
 =?iso-2022-jp?B?bDdJSFBibXk0cVVtNFVCZVNENFpuNk9sQ28zZXk3UUxDM2U3NU8wSHRl?=
 =?iso-2022-jp?B?RTRDbmp3N2RVQXRVWlNDZ0kzUmxsZXFVUmYvY1RtNUU3Q2dRU0UvanFN?=
 =?iso-2022-jp?B?amhxYU5jRW05RnViU3p6NStJYnBPSmJGQUdOaHRXb0hxSjBkL0lzd1JR?=
 =?iso-2022-jp?B?VGVIUUs1dEpRVTI5aHlLWlJGclZOMVVKV3gydkRDMUNWUXUzTW1MOTlM?=
 =?iso-2022-jp?B?Q0dlSEdrWWN2NFRRdEw3T1pMa3ptS25NeTVyVUc5SUpEQS9uOEZBemhy?=
 =?iso-2022-jp?B?eUk2M3hWTWlzYnhWbURYWW05dFJYSUxnWmRFQXV2Wnl6M3pMMTV2Sy9k?=
 =?iso-2022-jp?B?ZXdnNVNMRDQwYXVjczl3U00xS0lBUUZDSmd0bW0wSWFuZGxWaTErdEJM?=
 =?iso-2022-jp?B?dGV6WUtERlpWdjN6dVVhMmVkY3duVjFxQU1Rc3Y2YWpzQ2hHMzV3VDli?=
 =?iso-2022-jp?B?ZU1PRllmbDdjamZoR05HcHpLb2FpSmJCZWE2TUhrb2NmUFpwZVRKVVNm?=
 =?iso-2022-jp?B?dXcraTNtQ2FROGNTZm8xSjVjOFVwTnFTQzRvOFZ0N0lIaXZRZ3JzWDBY?=
 =?iso-2022-jp?B?cGRnQWl2U0xBSE5wWTYxMDNwVFFWc0JiUTlUMGJWU2IyY1ZvQVVQajM4?=
 =?iso-2022-jp?B?Rnd6R3VkMFdBWGM5OTBmZnJxZUhmWGJGL1QzMEJpOWthZ1gzTy8wVGZk?=
 =?iso-2022-jp?B?aWRtaCt3dzJ6UmhGTVhTbTRyZEIrTWlrVENrd0lIRkduVmNwTW9hUXlj?=
 =?iso-2022-jp?B?Uzd1Q3RaQ3diUlZ1bkljTFFFKytKcVh1SHk3WHd0T1NscktiRDg1Rk9q?=
 =?iso-2022-jp?B?Ni9yUFNmbDdWa2pNTE5kclVQVWZTMkN5VVZML2hxSUZvMTVZd3hZUFlE?=
 =?iso-2022-jp?B?cWkzbFMrY0NmTThLQnJ2SDl6bW1EWndRZnNNeTIveGRzOWRlcDFFaTRa?=
 =?iso-2022-jp?B?MVVkT0VKT0NUbDlaR1NuVHBXaHlIRy9lOUdibnVqdkRmcEpJQmhOQ2pl?=
 =?iso-2022-jp?B?UEp2Q3VKbmJVS1VHZGxvSXl0VGV4UDM1TGUvaFpzVDZIRTZKbUIyTWJY?=
 =?iso-2022-jp?B?bXZvR09rZ0E3Tm1aVkZWZjVpME90NTNnVTRFNE9JU3FIdjgxZjVMSXVJ?=
 =?iso-2022-jp?B?ekNmYURCNjUrRnFwK1N0USt6Tk1yaUJMeGV1QmhZc0hSRVZWZ21BWVFI?=
 =?iso-2022-jp?B?NDYxNzk5NjlCMFoxSUJYWWZ3L0o4VjlwVnpLZER1TTZiK2ZsREJNU0dC?=
 =?iso-2022-jp?B?UC9UREtNOUQwNE90RjE4RXFsVVkzOHRzMVBjQU0yUEZDOUxja01JSnJu?=
 =?iso-2022-jp?B?TTRVQnU4bmhGV0pzMTR2NVRMQUJZWjVJNjdpQ2x1Mml1eTBabnRmb0s2?=
 =?iso-2022-jp?B?aXBJaXlaMHo4WjBDMGRUdkMzejdsV0N6RjVBdnJDNVVtaWhSNEw5dlZJ?=
 =?iso-2022-jp?B?WWcxOTIrUXZyM0R5TU1QeU0wVXhkMzF0UjVJTnFHNm5pcFFpaGp2bWE3?=
 =?iso-2022-jp?B?SkxtU1RSalNPRHNjVm0zTENmMjhtUUFHS2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a545425-ae4a-4a65-10ff-08dc94f61a04
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 09:06:29.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zt/ZL/pbYiPOUvTGcy4D7iyfaiffNX4lbThagouXfL8br2kGzX66mMnQmiwwA3WPvhIxJFv/JgmpkU1IeRA1xoKhsidAaoMzturpgS/lJbrKxGMWk5zDklBMYuN1z8Xe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10991
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Jun 2024 09:06:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16321

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Friday, June 21, 2024 3:51 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Cc: Pavel Machek <pavel@denx.de>
> Subject: RE: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the
> atomic flag
>=20
> Hi Nobuhiro Iwamatsu,
>=20
> Thanks for the patch.
>=20
> > -----Original Message-----
> > From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Sent: Friday, June 21, 2024 2:58 AM
> > Subject: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the
> > atomic flag
> >
> > From: Alex Deucher <alexdeucher@gmail.com>
> >
> > commit e431eb8089eef1477082d6ae072ac252699b231f upstream.
> >
> > Use the per device drm driver feature flags rather than the global
> > one.  This way we can make the drm driver struct const.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Link:
> >
> https://patchwork.freedesktop.org/patch/msgid/20201104100425.1922351-3
> > -daniel.vetter@ffwll.ch
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202406210812.Au5U3OkG-lkp@intel.
> > com/
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> I guess this issue is introduced due to [1]
>=20
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit/=
?h
> =3Dlinux-5.10.y-cip&id=3D2a78ff0b0ab60ac2fb3cc6ea6b4895e2a7e7e769
>=20

Thanks for your review, applied.

Best regards,
  Nobuhiro


