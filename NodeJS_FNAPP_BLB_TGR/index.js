module.exports = async function(context, myBlob) {
    context.log(`Blob trigger function executed at ${new Date().toISOString()}`);
    context.log(`Blob Name: ${context.bindingData.name}`);
    context.log(`Blob Size: ${myBlob.length} bytes`);

    const fileContents = myBlob.toString('utf8');
    context.log(`File Contents: ${fileContents}`);
};
