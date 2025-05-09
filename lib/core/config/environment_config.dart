/// Configuration class for managing environment-specific settings.
/// This allows for different configurations in development, testing,
/// and production environments.
class EnvironmentConfig {
  /// The current environment (dev, staging, prod)
  final Environment environment;
  
  /// Whether to use mock implementations instead of real API services
  final bool useMockServices;
  
  /// Azure Speech Service configuration
  final String speechServiceBaseUrl;
  final String speechApiKey;
  final String speechRegion;
  
  /// Azure AI Service configuration
  final String azureAIEndpoint;
  final String azureApiKey;
  final String azureDeploymentName;
  final String azureAPIVersion;
  
  const EnvironmentConfig({
    required this.environment,
    required this.useMockServices,
    required this.speechServiceBaseUrl,
    required this.speechApiKey,
    required this.speechRegion,
    required this.azureAIEndpoint,
    required this.azureApiKey,
    required this.azureDeploymentName,
    required this.azureAPIVersion,
  });
  
  /// Development environment configuration
  static final EnvironmentConfig dev = EnvironmentConfig(
    environment: Environment.dev,
    useMockServices: true, // Use mock services in development by default
    speechServiceBaseUrl: 'https://eastus2.api.cognitive.microsoft.com/',
    speechApiKey: 'dev_speech_key', // Replace with actual dev key
    speechRegion: 'eastus2',
    azureAIEndpoint: 'https://eastus2.api.cognitive.microsoft.com/',
    azureApiKey: 'dev_azure_key', // Replace with actual dev key
    azureDeploymentName: 'your-deployment-name',
    azureAPIVersion: '2023-05-15', // Update to the latest version as needed
  );
  
  /// Staging environment configuration
  static final EnvironmentConfig staging = EnvironmentConfig(
    environment: Environment.staging,
    useMockServices: false,
    speechServiceBaseUrl: 'https://eastus2.api.cognitive.microsoft.com/',
    speechApiKey: 'staging_speech_key', // Replace with actual staging key
    speechRegion: 'eastus2',
    azureAIEndpoint: 'https://eastus2.api.cognitive.microsoft.com/',
    azureApiKey: 'staging_azure_key', // Replace with actual staging key
    azureDeploymentName: 'your-deployment-name',
    azureAPIVersion: '2023-05-15', // Update to the latest version as needed
  );
  
  /// Production environment configuration
  static final EnvironmentConfig prod = EnvironmentConfig(
    environment: Environment.prod,
    useMockServices: false,
    speechServiceBaseUrl: 'https://eastus2.api.cognitive.microsoft.com/',
    speechApiKey: 'AAVpE7QoR24xDP0T1dSSSrb1UjQLtyMZvBmhjyrhtdsw7SDBvdAaJQQJ99BEACHYHv6XJ3w3AAAYACOGhF80', // From your existing config
    speechRegion: 'eastus2',
    azureAIEndpoint: 'https://eastus2.api.cognitive.microsoft.com/',
    azureApiKey: 'AAVpE7QoR24xDP0T1dSSSrb1UjQLtyMZvBmhjyrhtdsw7SDBvdAaJQQJ99BEACHYHv6XJ3w3AAAYACOGhF80', // Using the same key for now
    azureDeploymentName: 'your-deployment-name',
    azureAPIVersion: '2023-05-15', // Update to the latest version as needed
  );
  
  /// The current active configuration
  /// Update this line to change the active environment
  static final EnvironmentConfig current = dev;
}

/// Enum representing different environments
enum Environment {
  dev,
  staging,
  prod,
}