pipeline 
{     
agent any     
stages 
{                  
stage('Deploy') 
{             
steps 
{                 
echo "Deploying to Testing"                 
sshPublisher(publishers: [sshPublisherDesc(configName: 'My_GC_VM', transfers: [sshTransfer(cleanRemote: false, excludes: '**/*.bak, **/*.git, **/*.gitignore,.htaccess', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html/', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '**/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])             
}         
}     
} 
}
