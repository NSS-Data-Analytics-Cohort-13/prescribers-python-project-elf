select d.opioid_drug_flag, SUM(p.total_claim_count) as highest_county_claim, zf.fipscounty, fc.county, fc.state, Round(SUM(p.total_claim_count)/pop.population,2) as prescription_per_capita
from prescription as p
Inner Join drug as d
on d.drug_name=p.drug_name
inner join prescriber as pr
on p.npi=pr.npi
inner join zip_fips as zf
on pr.nppes_provider_zip5=zf.zip
left join fips_county as fc
on zf.fipscounty=fc.fipscounty
inner join population as pop
on fc.fipscounty=pop.fipscounty
where opioid_drug_flag = 'Y' and fc.state = 'TN'
group by 1,3,4,5,pop.population
order by prescription_per_capita DESC
