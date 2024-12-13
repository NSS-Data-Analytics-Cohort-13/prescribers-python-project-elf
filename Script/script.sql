--Which Tennessee counties had a disproportionately high number of opioid prescriptions?


SELECT fc.county
	, SUM(pr.total_claim_count) AS total_opioid_prescriptions
	, SUM(pr.total_claim_count) / pop.population AS prescriptions_per_capita 
FROM prescription AS pr 
INNER JOIN prescriber AS p ON pr.npi = p.npi 
	INNER JOIN zip_fips AS z ON p.nppes_provider_zip5 = z.zip 
INNER JOIN drug AS d ON pr.drug_name = d.drug_name 
	INNER JOIN fips_county AS fc ON z.fipscounty = fc.fipscounty 
INNER JOIN population AS pop ON fc.fipscounty = pop.fipscounty 
WHERE d.opioid_drug_flag = 'Y' AND fc.state = 'TN' 
GROUP BY fc.county, pop.population 
ORDER BY prescriptions_per_capita DESC;






